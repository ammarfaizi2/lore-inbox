Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUGMNAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUGMNAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGMNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:00:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13993 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264980AbUGMM7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:59:40 -0400
Date: Tue, 13 Jul 2004 07:59:03 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, dhowells@redhat.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       slpratt@us.ibm.com
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040713125903.GC9149@rx8.austin.ibm.com>
References: <20040712175605.GA1735@rx8.austin.ibm.com> <20040713023721.GA7461@austin.ibm.com> <1089699910.19847.13357.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1089699910.19847.13357.camel@nighthawk> (from haveblue@us.ibm.com on Tue, Jul 13, 2004 at 01:25:10 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 01:25:10, Dave Hansen wrote:
> Do you worry that you're just expanding the hash table as long as it
> gives benefit on your one, single benchmark?  There have to be plenty of
> other workloads that could benefit from an extra 1/16th more memory. 
> Not every workload is as dcache heavy as SFS.  

This does not change the normal behavior of the kernel. This only
has effect when you use the cmdline options to increase it.  I only 
use 1/256 of my memory for hashes but there might be someone else
crazier than me that wants more.  Of course the 1/16 number could be
change to something a lot smaller but i should give people some room
to play with.

-JRS
