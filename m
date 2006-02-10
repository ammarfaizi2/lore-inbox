Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWBJNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBJNWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBJNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:21:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30664 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751255AbWBJNV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:21:56 -0500
Date: Fri, 10 Feb 2006 14:21:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
In-Reply-To: <9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com> 
 <m1pslystkz.fsf@ebiederm.dsl.xmission.com>  <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr>
  <m1r76c2yhf.fsf@ebiederm.dsl.xmission.com>
 <9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Any of those 3 scheemes should keep pids below 6 digits as much as
>possible. We can still hit the cosmetic problem on boxes where more
>than 99999 processes are actually running at the same time, but most
>users will never encounter that.
>
I'd say let's remain doing whatever we're doing now. That is, a maximum of 
32768 concurrent pids, and whoever needs more (e.g. Sourceforge shell, 
etc.) can always raise it to their needs.


Jan Engelhardt
-- 
