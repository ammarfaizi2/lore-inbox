Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287543AbSAEGHd>; Sat, 5 Jan 2002 01:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287542AbSAEGHY>; Sat, 5 Jan 2002 01:07:24 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:59145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287543AbSAEGHM>;
	Sat, 5 Jan 2002 01:07:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Bombe <bombe@informatik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i810_audio.c .text.exit reference in 2.4.17 
In-Reply-To: Your message of "Fri, 04 Jan 2002 22:50:40 BST."
             <20020104215040.GA3020@storm.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Jan 2002 17:07:00 +1100
Message-ID: <7131.1010210820@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 22:50:40 +0100, 
Andreas Bombe <bombe@informatik.tu-muenchen.de> wrote:
>I just want to mention that i810_audio.c suffers from referencing a
>symbol in .text.exit(i810_remove), too, with the usual symptoms.

If the reference is coming from .text.lock then there is a patch
waiting for Marcelo to fix that.  If the reference is coming from
another section then it is a bug.

