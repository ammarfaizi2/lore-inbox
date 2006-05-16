Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWEPRmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWEPRmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWEPRmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:42:01 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:14225 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932178AbWEPRmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:42:00 -0400
Subject: Re: [PATCH] typo in i386/init.c [BugMe #6538]
From: Dave Hansen <haveblue@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060516173421.GB4341@us.ibm.com>
References: <20060516165040.GA4341@us.ibm.com>
	 <20060516102427.2c50d469.akpm@osdl.org>  <20060516173421.GB4341@us.ibm.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 10:40:16 -0700
Message-Id: <1147801216.6623.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 10:34 -0700, Nishanth Aravamudan wrote:
> > So there's something fishy going on here.
> 
> I won't deny that :)

I think the fishiness probably comes from the apparent fact that nobody
besides me ever enabled sparsemem, then memory hotplug on x86.  I never
caught or hit it because I never tried that config without the other
patches that make "fake hotplug" work on x86.  

-- Dave

