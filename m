Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHRQk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHRQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHRQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:40:57 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:1484 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932301AbVHRQk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:40:56 -0400
Date: Thu, 18 Aug 2005 12:40:51 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Elliot Lee <sopwith@redhat.com>
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
 (update)
In-Reply-To: <1124381951.6251.14.camel@w2>
Message-ID: <Pine.LNX.4.63.0508181239290.21390@excalibur.intercode>
References: <1124326652.8359.3.camel@w2>  <p7364u40zld.fsf@verdi.suse.de>
 <1124381951.6251.14.camel@w2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Wieland Gmeiner wrote:

> On Thu, 2005-08-18 at 04:05 +0200, Andi Kleen wrote:
> 
> > Is there a realistic use case where this new system call is actually useful
> > and solves something that cannot be solved without it?
> 
> As an example: It seems to be a common problem with numerous services to
> run out of available file descriptors. There are several workarounds to
> this problem, the most common seems to be increasing the systemwide max
> number of filedescriptors and restarting the service. If you google for
> e.g. 'linux "too many open files"' you get a bunch of mailing list
> support requests about that problem.

This is a system tuning issue, not justification for two new system calls.


- James
-- 
James Morris
<jmorris@namei.org>
