Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTDMC6d (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 22:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263114AbTDMC6d (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 22:58:33 -0400
Received: from [12.47.58.73] ([12.47.58.73]:12680 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263113AbTDMC6c (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 22:58:32 -0400
Date: Sat, 12 Apr 2003 20:10:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jeremy Hall <jhall@maoz.com>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-Id: <20030412201011.0d3dfa62.akpm@digeo.com>
In-Reply-To: <200304130303.h3D33kkr031006@sith.maoz.com>
References: <1050198928.597.6.camel@teapot.felipe-alfaro.com>
	<200304130303.h3D33kkr031006@sith.maoz.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 03:10:11.0633 (UTC) FILETIME=[322AC210:01C3016A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Hall <jhall@maoz.com> wrote:
>
> I dunno about that, but mm2 locks in the boot process and doesn't display 
> anything to me through gdb even though it is supposed to.  I have gdb 
> console=gdb but that doesn't make the messages flow.
> 

You want "gdb console=gdb".  It changed.

What CPU type?

Try just 2.5.67 plus 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm2/broken-out/linus.patch

try disabling kgdb in config.

etcetera.

