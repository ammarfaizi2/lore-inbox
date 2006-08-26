Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWHZKL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWHZKL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 06:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 06:11:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751049AbWHZKL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 06:11:58 -0400
Date: Sat, 26 Aug 2006 12:11:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Safford <safford@watson.ibm.com>
Cc: Serge E Hallyn <sergeh@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       David Safford <safford@us.ibm.com>, kjhall@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060826101140.GE10257@elf.ucw.cz>
References: <20060817230213.GA18786@elf.ucw.cz> <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com> <20060824054933.GA1952@elf.ucw.cz> <20060824130340.GB15680@sergelap.austin.ibm.com> <20060824131127.GB7052@elf.ucw.cz> <1156442454.2476.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156442454.2476.46.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Do you have examples where this security model stops an attack?
> 
> The main goal of this model is to stop some of the most common real 
> attacks on client machines, in particular the downloading and execution
> of malicious code, through a browser or email attachment. By making

Well, I have seen those attacks on windows, but never on Linux. x bit
seems to help here.

> In one demo I like to run, I deliberately download a trojaned game, and
> run it both as a user and even as root/system. Since the game is labeled
> untrusted, it is invoked untrusted regardless of who runs it.

That's okay, but that game can still get your browsing habits, steal
your credit card numbers, and probably get your ssh passwords.

...so it may not be so good demo after all...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
