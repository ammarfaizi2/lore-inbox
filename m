Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVDYMcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVDYMcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVDYMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 08:32:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11483 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262593AbVDYMcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 08:32:39 -0400
Date: Mon, 25 Apr 2005 14:32:36 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Message-ID: <20050425123236.GC26665@pasky.ji.cz>
References: <426CD1F1.2010101@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426CD1F1.2010101@tiscali.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Apr 25, 2005 at 01:18:09PM CEST, I got a letter
where Matthias-Christian Ott <matthias.christian@tiscali.de> told me that...
> The "git" didn't try store small variables, which aren't referenced, in 
> the processor registers. It also didn't use the size_t type. I corrected 
> a C++ style comment too.

Honestly, I don't think using the register keyword helps anything but to
make the code less readable.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
