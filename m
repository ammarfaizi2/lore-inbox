Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSKCKl7>; Sun, 3 Nov 2002 05:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSKCKl6>; Sun, 3 Nov 2002 05:41:58 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26643 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261733AbSKCKl4>;
	Sun, 3 Nov 2002 05:41:56 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Compatible with old bash, fix help, make clean fix 
In-reply-to: Your message of "Sun, 03 Nov 2002 09:51:47 BST."
             <20021103085147.GA3433@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Nov 2002 21:48:13 +1100
Message-ID: <22127.1036320493@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002 09:51:47 +0100, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>o Added AWK, a few architectures actually use awk for normal compilation

Needs to be exported as well.
-	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE GENKSYMS PERL UTS_MACHINE \
+	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE GENKSYMS PERL AWK UTS_MACHINE \

