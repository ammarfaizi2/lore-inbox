Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSJVUPx>; Tue, 22 Oct 2002 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJVUOy>; Tue, 22 Oct 2002 16:14:54 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:21010 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264931AbSJVUN6>;
	Tue, 22 Oct 2002 16:13:58 -0400
Date: Tue, 22 Oct 2002 22:19:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Grothe <dave@gcom.com>, Ingo Molnar <mingo@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli
Message-ID: <20021022221923.A2859@mars.ravnborg.org>
Mail-Followup-To: David Grothe <dave@gcom.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20021022145759.02861ec8@localhost>; from dave@gcom.com on Tue, Oct 22, 2002 at 03:01:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 03:01:47PM -0500, David Grothe wrote:
> In 2.5.41every architecture except Intel 386 has a "#define cli 
> <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> define in asm-i386/system.h?  If not, where does the "official" definition 
> of cli() live for Intel?  Or what is the include file that one needs to 
> pick it up?  I can't find it.

I would advise you to read: Documentation/cli-sti-removal.txt
[I recall someone mentioned this documents were slightly out-dated - Ingo?]

The short version is that cli() is no loger valid, drivers using it does not compile.

	Sam
