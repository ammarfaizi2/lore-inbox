Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSDNA1c>; Sat, 13 Apr 2002 20:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311530AbSDNA1b>; Sat, 13 Apr 2002 20:27:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41744 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310666AbSDNA1b>;
	Sat, 13 Apr 2002 20:27:31 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: FIXED_486_STRING ? 
In-Reply-To: Your message of "Sat, 13 Apr 2002 22:47:43 +0600."
             <20020413224743.A13355@natasha.zzz.zzz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Apr 2002 10:27:18 +1000
Message-ID: <32667.1018744038@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Apr 2002 22:47:43 +0600, 
Denis Zaitsev <zzz@cd-club.ru> wrote:
>What is the state of the FIXED_486_STRING macro?  It is used once thru
>all the kernel tree - in include/asm-i386/string.h - and it seems that
>its role is to disable a usage of string-486.h completely...  Am I
>right?

Dead code, it has been dead since at least 2.0.21.  Unless somebody
wants to fix the string-486 code, delete FIXED_486_STRING,
CONFIG_X86_USE_STRING_486 and include/asm-i386/string-486.h.

