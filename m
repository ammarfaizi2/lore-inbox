Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSAIO5x>; Wed, 9 Jan 2002 09:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSAIO5n>; Wed, 9 Jan 2002 09:57:43 -0500
Received: from codepoet.org ([166.70.14.212]:13066 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S286962AbSAIO5Z>;
	Wed, 9 Jan 2002 09:57:25 -0500
Date: Wed, 9 Jan 2002 07:57:23 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109145723.GB17918@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Juan Quintela <quintela@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020108192450.GA14734@kroah.com> <20020109042331.GB31644@codeblau.de> <m2elkzslnh.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2elkzslnh.fsf@trasno.mitica>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 09, 2002 at 02:23:46PM +0100, Juan Quintela wrote:
> I can think of that in a fast thought:
> 
> - if fsck.* can be there, it will make fs nice, just now they have to
>   be able to fsck a ro root fs.

That would be a nice addition.

> - I suppose that you can put here also the raid autodetect code and
>   things like that.
> - you also need a very small minishell, something like nash (that
>   cames with mkinitrd will suffice).

busybox lash
    http://busybox.net/cgi-bin/cvsweb/busybox/shell/lash.c?rev=1.142&content-type=text/vnd.viewcvs-markup
or busybox msh or busybox ash if you need something thats
all posix compliant. 

> - as I suppose that you have supposed insmod is essential :)

busybox insmod

> - you already put there IP autoconfiguration.

udhcp

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
