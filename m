Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSENMA1>; Tue, 14 May 2002 08:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSENMA0>; Tue, 14 May 2002 08:00:26 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:38670 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315627AbSENMAZ>; Tue, 14 May 2002 08:00:25 -0400
Date: Tue, 14 May 2002 13:00:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514130018.C18118@flint.arm.linux.org.uk>
In-Reply-To: <20020514123830.A18118@flint.arm.linux.org.uk> <E177b8s-0007lm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 01:10:58PM +0100, Alan Cox wrote:
> I don't even Martin here, the ide locking is currently utterly vile

Agreed.

I'm adding BUG_ON()s to the IDE drivers I maintain where we must ensure
only one channel is DMAing to catch possible data corruption before it
happens.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

