Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbSI3S4D>; Mon, 30 Sep 2002 14:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261282AbSI3S4D>; Mon, 30 Sep 2002 14:56:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56837 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261281AbSI3S4C>; Mon, 30 Sep 2002 14:56:02 -0400
Date: Mon, 30 Sep 2002 20:01:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 compile failiure
Message-ID: <20020930200125.B31682@flint.arm.linux.org.uk>
References: <200209301437.g8UEbY0r005753@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209301437.g8UEbY0r005753@darkstar.example.net>; from jbradford@dial.pipex.com on Mon, Sep 30, 2002 at 03:37:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 03:37:35PM +0100, jbradford@dial.pipex.com wrote:
> drivers/built-in.o: In function `__uart_register_port':
> drivers/built-in.o(.text+0x2123): undefined reference to `uart_type'

Oops, misplaced #ifdef CONFIG_PROC_FS.  Thanks for finding it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

