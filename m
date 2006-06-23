Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932970AbWFWJiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbWFWJiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932971AbWFWJiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:38:05 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:6341 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932970AbWFWJiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:38:03 -0400
Date: Fri, 23 Jun 2006 13:38:55 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: Mark Underwood <basicmark@yahoo.com>
Cc: greg@kroah.com, i2c@lm-sensors.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [i2c] [PATCH] I2C bus driver for Philips ARM boards
Message-Id: <20060623133855.59b08f33.vitalywool@gmail.com>
In-Reply-To: <20060622222600.49601.qmail@web36915.mail.mud.yahoo.com>
References: <20060622203559.GA14445@kroah.com>
	<20060622222600.49601.qmail@web36915.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 23:26:00 +0100 (BST)
Mark Underwood <basicmark@yahoo.com> wrote:
 
> Would it not make sense to call this driver ip3204 or ph_ip3204 or some such seeing as you
> correctly point out that this is a common Philips IP block and is used in other, non pnx, chips?

No I don't think it would -- this is an internal Philips IP block number AFAIK and was given there only for reference.
Funny is that people from Philips Semi asked me about a year ago not to use internal IP block numbers in the code. I know you're also from Philips... Well, what does that prove? It proves that everything can't be in alignment in such a big company. ;-)
 
> I'm also not sure why the register map is in the arch-pnx4008 directory as this will require every
> chip that has this IP block to have a copy of the file.

IIRC, PNX5220 has a slightly different register map. Of course the main registers are the same but putting first N regs into common header and putting others into arch header would have made even less sense.

Vitaly
