Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRK2HT5>; Thu, 29 Nov 2001 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283039AbRK2HTr>; Thu, 29 Nov 2001 02:19:47 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:12419 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283016AbRK2HTh>; Thu, 29 Nov 2001 02:19:37 -0500
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: oliver@neukum.org
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David C. Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH] remove BKL from drivers' release functions
Date: Thu, 29 Nov 2001 08:17:31 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C059087.9070900@us.ibm.com> <3C059269.92CA09A2@mandrakesoft.com>
In-Reply-To: <3C059269.92CA09A2@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01112908173102.00732@argo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Alan Cox made the comment on IRC that BKL was put into the release
> method in 2.4 to synchronize open-close-power management.  Don't forget
> to take that third into account either, in the cases where such applies.

And device unplugging please.

	Regards
		Oliver
