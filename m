Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSGLAVK>; Thu, 11 Jul 2002 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317949AbSGLAVJ>; Thu, 11 Jul 2002 20:21:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7183 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317950AbSGLAVJ>;
	Thu, 11 Jul 2002 20:21:09 -0400
Message-ID: <3D2E211E.24CF19B0@zip.com.au>
Date: Thu, 11 Jul 2002 17:21:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Dawson Engler <engler@csl.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
References: <200207112135.OAA03801@csl.Stanford.EDU> <Pine.LNX.4.44.0207111711530.26269-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> 
> Hi,
> 
> Here is the whole set.
> 

It's fair enough for a fix I guess.  But careful readers will
have observed that a goodly portion of these bugs are directly
due to the poor programming practice of putting more than one
return statement in a C function.

-
