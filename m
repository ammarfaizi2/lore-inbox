Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285435AbRLYJvG>; Tue, 25 Dec 2001 04:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285429AbRLYJu5>; Tue, 25 Dec 2001 04:50:57 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:14090 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S282683AbRLYJum>;
	Tue, 25 Dec 2001 04:50:42 -0500
Date: Mon, 24 Dec 2001 23:35:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jesper Juhl <jju@dif.dk>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] console_loglevel broken on ia64 (and possibly other archs)
Message-ID: <20011224233515.B3932@elf.ucw.cz>
In-Reply-To: <3C23BD30.F8C3B2E1@dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C23BD30.F8C3B2E1@dif.dk>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch fixes the console_loglevel variable(s) so that code that
> assumes the variables occupy continuous storage does not break (and
> overwrite other data).

It seems to me you are adding feature? And unneeded one, also.
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
