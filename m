Return-Path: <linux-kernel-owner+w=401wt.eu-S1751674AbWLNRto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWLNRto (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWLNRto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:49:44 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46694 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbWLNRtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:49:42 -0500
Date: Thu, 14 Dec 2006 18:48:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
In-Reply-To: <458153F3.4040203@argo.co.il>
Message-ID: <Pine.LNX.4.61.0612141847370.12730@yvahk01.tjqt.qr>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il>
 <200612141125.14777.hjk@linutronix.de> <45812C17.4090309@argo.co.il>
 <Pine.LNX.4.61.0612141338490.6223@yvahk01.tjqt.qr> <458153F3.4040203@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Dec 14 2006 15:38, Avi Kivity wrote:
> Jan Engelhardt wrote:
>> > It has to be written once, but compiled for every kernel
>> > version and $arch out there (for out of tree drivers), or it
>> > has to wait for the next kernel release and distro sync (for
>> > in-tree drivers).
>> 
>> Still better than written for every _and_ compiled for every.
>> But wait, make it simpler: just give the source to the user and
>> don't bother with precompiling. It's such a PITA anyhow.
>
> Users don't compile.  They use.  That's why they're called users.

I could also take your wording: Users don't install. They use. ...

> And please don't suggest wrapper scripts to do the compilation.

Hell no. I can't already compile VMware without sanitizing the Makefile
beforehand.


	-`J'
-- 
