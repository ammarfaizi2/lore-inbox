Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSKJWag>; Sun, 10 Nov 2002 17:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265221AbSKJWag>; Sun, 10 Nov 2002 17:30:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:7261 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265205AbSKJWag> convert rfc822-to-8bit;
	Sun, 10 Nov 2002 17:30:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Mehrmann <daniel.mehrmann@gmx.de>
To: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4: Merge Emulex and Qlogic FC drivers ?
Date: Sun, 10 Nov 2002 23:37:17 +0100
User-Agent: KMail/1.4.3
References: <200211102302.39468.daniel.mehrmann@gmx.de> <6ulm419int.fsf@zork.zork.net>
In-Reply-To: <6ulm419int.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211102337.17028.daniel.mehrmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 November 2002 23:14, Sean Neakums wrote:
> commence  Daniel Mehrmann quotation:
> > i want merge the linux driver for FC controllers from Qlogic
> > and Emulex (All series from both) into the kernel tree, because
> > i need this for our company.
> >
> > Qlogic is clear GPL but Emulex have no GPL.
> > I think the license to use the code is free and i see no
> > problems.
>
> The last time I looked at an Emulex Linux driver (for the
> LP-7000, about six months ago), it consisted of a large
> binary-only portion, shipped in a .a file, and the source code
> for a shim to have the library code talk to the kernel.
>
> Furthermore, the driver was configured by editing a .c file and
> rebuilding it.
>
> All in all, a quality experience.

Mh, i have the complete source code. Only the hba access 
for IP over FC is binary, but that`s a libary api for userland 
tools. I only want merge the standalone driver for both products. 
If i do this, i must add this to a readme file.  

greetings
DAniel
