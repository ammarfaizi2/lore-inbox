Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318801AbSG0SPu>; Sat, 27 Jul 2002 14:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSG0SPu>; Sat, 27 Jul 2002 14:15:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23047 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318801AbSG0SPu>; Sat, 27 Jul 2002 14:15:50 -0400
Date: Sat, 27 Jul 2002 19:19:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com
Subject: Re: Serial Oopsen caused by global IRQ chanes
Message-ID: <20020727191906.D32766@flint.arm.linux.org.uk>
References: <20020727191119.C32766@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020727191119.C32766@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Jul 27, 2002 at 07:11:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 07:11:19PM +0100, Russell King wrote:
> Two people have now reported to me a couple of oopsen which appear to be
> caused by a change in 2.5.29 to synchronize_irq(), which I believe has
> made synchronize_irq() useless.

Sorry, not useless.  Just free_irq extremely buggy.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

