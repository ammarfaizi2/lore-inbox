Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTBRUlL>; Tue, 18 Feb 2003 15:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbTBRUlJ>; Tue, 18 Feb 2003 15:41:09 -0500
Received: from magic.adaptec.com ([208.236.45.80]:52460 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S268004AbTBRUlG>; Tue, 18 Feb 2003 15:41:06 -0500
Date: Tue, 18 Feb 2003 13:50:06 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] aic7xxx/aicasm makefile - fix make clean
Message-ID: <9080000.1045601406@aslan.btc.adaptec.com>
In-Reply-To: <20030216193229.GA22723@mars.ravnborg.org>
References: <20030216193229.GA22723@mars.ravnborg.org>
X-Mailer: Mulberry/3.0.0b12 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The latest change to aic7xxx/aicasm/makefile broke make clean.
> The following patch re-enable "make-clean" and keep the clean: target.

I just renamed CLEANFILES to clean-files and added $(PROG) to it.  It
should do the same thing.

--
Justin

