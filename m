Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291329AbSAaVmN>; Thu, 31 Jan 2002 16:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291339AbSAaVmD>; Thu, 31 Jan 2002 16:42:03 -0500
Received: from zero.tech9.net ([209.61.188.187]:40972 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291329AbSAaVlz>;
	Thu, 31 Jan 2002 16:41:55 -0500
Subject: Re: [PATCH] 2.5: further llseek cleanup (3/3)
From: Robert Love <rml@tech9.net>
To: Guillaume Chamberland-Larose 
	<Guillaume.Chamberland-Larose@ift.ulaval.ca>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <1012500123.3c59869bbbff0@courriel.ift.ulaval.ca>
In-Reply-To: <1012497140.3219.163.camel@phantasy> 
	<1012500123.3c59869bbbff0@courriel.ift.ulaval.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 16:47:52 -0500
Message-Id: <1012513673.3392.170.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 13:02, Guillaume Chamberland-Larose wrote:

> I was reading through your patch and got confused: shouldn't you call 
> unlock_kernel() before you return( ret ) 
> in linux-2.5.3/arch/cris/drivers/eeprom.c
> 
> Just my 0.02$

Indeed, thank you for pointing that out.  An updated version is
available at:

ftp://ftp.kernel.org/pub/linux/kernel/people/rml/kill-bkl/llseek/push-bkl-llseek-rml-2.5.3-3.patch

	Robert Love

