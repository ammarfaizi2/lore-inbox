Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSEBUJh>; Thu, 2 May 2002 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315392AbSEBUJg>; Thu, 2 May 2002 16:09:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55824 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315388AbSEBUJe>; Thu, 2 May 2002 16:09:34 -0400
Date: Thu, 2 May 2002 21:09:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: antonelloderosa@inwind.it,
        "'root@chaos.analogic.com'" <root@chaos.analogic.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Controlling the serial port at kernel level
Message-ID: <20020502210926.H24630@flint.arm.linux.org.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A77CF@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 11:31:45AM -0700, Ed Vance wrote:
> That will get the UART initialized and held in an 
> operational state while you program the MCR register from inside 
> the kernel to change the modem signal states.

You don't need the UART initialised to wiggle the RTS and DTR signals -
as far as standard ports go (rather than the fancy ones that do flow
control), they're just simple IO lines.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

