Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311635AbSCXR6k>; Sun, 24 Mar 2002 12:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311641AbSCXR6a>; Sun, 24 Mar 2002 12:58:30 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:3811 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id <S311635AbSCXR6Y> convert rfc822-to-8bit; Sun, 24 Mar 2002 12:58:24 -0500
Message-Id: <200203241757.SAA20700@piggy.rz.tu-ilmenau.de>
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
Date: Sun, 24 Mar 2002 18:57:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andreas <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0203241444560.18660-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Sun, 24 Mar 2002, Roy Sigurd Karlsbakk wrote:
> > Would it hard to do some memory allocation statistics, so if some
> > process at one point (as rsync did) goes crazy eating all memory, that
> > would be detected?
>
> No.  What I doubt however is whether it would be worth it,
> since most machines never run OOM.

Well, I think could be worth in terms of security, because a local user could 
use a bad memory-eating program to produce an Denial of Service of other 
processes.

Unfortunately detecting a program, written to cause harm is harder than 
detecting a crazy program.

greetings

Christian
