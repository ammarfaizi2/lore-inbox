Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSKHAms>; Thu, 7 Nov 2002 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbSKHAms>; Thu, 7 Nov 2002 19:42:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62725 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266693AbSKHAmq>; Thu, 7 Nov 2002 19:42:46 -0500
Date: Fri, 8 Nov 2002 00:49:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Martin Diehl <lists@mdiehl.de>
Subject: Re: [Serial 2.5]: packet drop problem (FE ?)
Message-ID: <20021108004924.H11437@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Martin Diehl <lists@mdiehl.de>
References: <20021107224750.GA699@bougret.hpl.hp.com> <20021108001822.E11437@flint.arm.linux.org.uk> <20021108004155.GA837@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021108004155.GA837@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Thu, Nov 07, 2002 at 04:41:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 04:41:55PM -0800, Jean Tourrilhes wrote:
> 	Is there a way to see the current flag configuration of the
> port with setserial or /proc ?

stty -a -F /dev/ttySx

should do the trick.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

