Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAKMlN>; Thu, 11 Jan 2001 07:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRAKMlD>; Thu, 11 Jan 2001 07:41:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29961 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130797AbRAKMkz>; Thu, 11 Jan 2001 07:40:55 -0500
Subject: Re: Floating point broken between 2.4.0-ac4 and -ac5?
To: junio@siamese.dhis.twinsun.com
Date: Thu, 11 Jan 2001 12:42:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <7vvgrmwuqv.fsf@siamese.dhis.twinsun.com> from "junio@siamese.dhis.twinsun.com" at Jan 10, 2001 08:58:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Gh42-00029E-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A Duron box running 2.4.0-ac5 (and -ac6) shows NaN in many
> places (such as df output showing usage "nan%").  Right now I
> reverted back to 2.4.0-ac4 which does not show the problem.
> The kernel was compiled with CONFIG_MK7 and without
> MATH_EMULATION, if that makes any difference.

If you boot with the nofxsr option does that fix the problem ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
