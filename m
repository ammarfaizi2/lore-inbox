Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132234AbRCVXFt>; Thu, 22 Mar 2001 18:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132231AbRCVXFk>; Thu, 22 Mar 2001 18:05:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132237AbRCVXFc>; Thu, 22 Mar 2001 18:05:32 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: andrew.grover@intel.com (Grover, Andrew)
Date: Thu, 22 Mar 2001 23:07:40 +0000 (GMT)
Cc: twoller@crystal.cirrus.com ('Woller Thomas'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7A2@orsmsx35.jf.intel.com> from "Grover, Andrew" at Mar 22, 2001 02:53:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEBC-0003Ve-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if there is a way to modify mdelay to use a kernel timer if
> interval > 10msec? I am not familiar with this section of the kernel, but I
> do know that Microsoft's similar function KeStallExecutionProcessor is not
> recommended for more than 50 *micro*seconds.

Basically the same kind of recommendation applies. But as with all rules its
sometimes appropriate to break it

