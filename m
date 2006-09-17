Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWIQJey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWIQJey (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 05:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWIQJex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 05:34:53 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:27379 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S932413AbWIQJex convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 05:34:53 -0400
Reveived: from web.de 
	by fmmailgate04.web.de (Postfix) with SMTP id 466F122F424;
	Sun, 17 Sep 2006 11:34:52 +0200 (CEST)
Date: Sun, 17 Sep 2006 11:34:50 +0200
Message-Id: <1313891898@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: show all modules which taint the kernel ?
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if there is a "contaminant" inside the kernel, why should one see this only when it`s being inserted (i.e. usually at boot time) ?

i don`t know about the "nvidia(P)..." thing, but i would find it really useful to be able to easily distinguish between the "good" and the "not belonging to this kernel" modules.

i have seem several discussions about "modules which taint the kernel are evil" - so why not pillory them by listing appropriate information with lsmod ?



> -----Ursprüngliche Nachricht-----
> Von: Lee Revell <rlrevell@joe-job.com>
> Gesendet: 17.09.06 02:01:05
> An: Dave Jones <davej@redhat.com>
> CC: linux-kernel@vger.kernel.org
> Betreff: Re: show all modules which taint the kernel ?


> On Sat, 2006-09-16 at 19:46 -0400, Dave Jones wrote:
> > On Sat, Sep 16, 2006 at 08:58:20PM +0200, devzero@web.de wrote:
> >  > but that "Modules linked in: radeon(U) drm(U) ipv6(U) autofs4(U)...." message has been reported to originate from a fc5 (fedora) kernel. fedora probably also using that novell/suse extension ?
> > 
> > Different. The Fedora kernel reports U for modules that weren't shipped with
> > the Fedora kernel. (It uses gpg signed modules).
> 
> Vendor kernels aside, would it be useful for mainline to report this
> information - something like nvidia(P) in the module list?
> 
> Lee
> 


_____________________________________________________________________
Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
http://smartsurfer.web.de/?mc=100071&distributionid=000000000066

