Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWBNPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWBNPLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBNPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:11:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:49863 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161068AbWBNPLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:11:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 16:09:54 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
Message-ID: <43F1F2C2.nailMWZGOQDYR@burner>
References: <43EEACA7.5020109@zytor.com>
 <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
 <43F09320.nailKUSI1GXEI@burner>
 <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>
> >> > I have noticed that the new ...at() system calls are named in what
> >> > appears to be a completely haphazard fashion.  In Unix system calls,
> >> > an f- prefix means it operates on a file descriptor; the -at suffix (a
> >> > prefix would have been more consistent, but oh well) similarly
> >> > indicates it operates on a (directory fd, pathname) pair.
> >> >
> >> shmat operates on dirfd/pathname?
> >
> >Do you have a better proposal for naming the interfaces?
> >
>
> chownfn maybe. (fd + name)

I am not shure if this would match the rules from the Opengroup.
Solaris has these interfaces since at least 5 years.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
