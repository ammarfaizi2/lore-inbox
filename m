Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSHGOMs>; Wed, 7 Aug 2002 10:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSHGOMs>; Wed, 7 Aug 2002 10:12:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:60153 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318035AbSHGOMr>; Wed, 7 Aug 2002 10:12:47 -0400
Subject: Re: compile error 2-4.20-pre1-ac1 -- AIC7xxx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020807142850.3a7a091b.stephane.wirtel@belgacom.net>
References: <20020807142850.3a7a091b.stephane.wirtel@belgacom.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 16:35:57 +0100
Message-Id: <1028734557.18130.306.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 13:28, Stephane Wirtel wrote:
> here is a compile error with 2.4.20-pre1-ac1

You chose to recompile the firmware

> make[4]: Entering directory `/root/linux-2.4.20-pre1-ac1/drivers/scsi/aic7xxx/aicasm'
> yacc -d -b aicasm_gram aicasm_gram.y
> make[4]: yacc: Command not found
> make[4]: *** [aicasm_gram.h] Error 127

on a box without the right tools installed.

Either install yacc or use the firmware prebuilt in the driver

