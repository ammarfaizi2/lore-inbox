Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760474AbWLFKs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760474AbWLFKs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760476AbWLFKs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:48:29 -0500
Received: from siolinb.obspm.fr ([145.238.2.18]:49093 "EHLO siolinb.obspm.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760466AbWLFKs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:48:28 -0500
Date: Wed, 6 Dec 2006 11:48:27 +0100 (CET)
From: Etienne.Vogt@obspm.fr
Reply-To: Etienne.Vogt@obspm.fr
To: linux-scsi <linux-scsi@vger.kernel.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Infinite retries reading the partition table
In-Reply-To: <20061130232916.6cbd1408.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612061144340.11674@siolinb.obspm.fr>
References: <20061130214716.6306a586.akpm@osdl.org> <117439.97789.qm@web31803.mail.mud.yahoo.com>
 <20061130232916.6cbd1408.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Nov 2006, Andrew Morton wrote:

> That looks like it prevents the IO error.  But why was an IO error causing
> an infinite loop?   What piece of code was initiating the retries?

Maybe it's related to the infinite domain validation retry loop problem
I reported on linux-scsi a few weeks ago ?

-- 
 		Etienne Vogt (Etienne.vogt@obspm.fr)
 		Observatoire de Paris-Meudon, France
