Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbTDAKYq>; Tue, 1 Apr 2003 05:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbTDAKYq>; Tue, 1 Apr 2003 05:24:46 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1028 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262230AbTDAKYo>; Tue, 1 Apr 2003 05:24:44 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200304011038.h31AcmeA000150@81-2-122-30.bradfords.org.uk>
Subject: Re: I compiled the kernel but it doesn't do any thing, its a bit like typing "halt".
To: dean.mcewan@eudoramail.com
Date: Tue, 1 Apr 2003 11:38:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <JLPADMLNKEGDACAA@whowhere.com> from "Dean McEwan" at Apr 01, 2003 10:28:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> init=/bin/sh is already defined in init/main.c isn't 
> it?

Once the kernel has booted, it usually passed control to init.  The
kernel usually looks for init in /sbin /etc and /bin, but if there is
no init in those locations, /bin/sh is looked for as a last resort.

I am assuming that you have an init on your system, but something is
wrong.  Using init=/bin/sh will allow you to use the shell as the init
process, which proves it's an init problem.

> I accidentally compiled initrd in, but ive got it off
> with "noinitrd".

I don't really understand what you're trying to do.

> >> whats system.map actually for
> >
> >Decoding numerical addresses in to function names.
> 
> Does it need to be put in /boot after compilation from
> the root linux source folder, 'coz the mandrake one
> for 2.4.19-16mdk is in there.

No.

John.
