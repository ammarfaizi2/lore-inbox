Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbRG3Lud>; Mon, 30 Jul 2001 07:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268532AbRG3LuX>; Mon, 30 Jul 2001 07:50:23 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35600 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268526AbRG3LuL>;
	Mon, 30 Jul 2001 07:50:11 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac3 
In-Reply-To: Your message of "Mon, 30 Jul 2001 12:43:29 +0100."
             <E15RBSL-0003cB-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 21:50:14 +1000
Message-ID: <23546.996493814@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 12:43:29 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>How about we do
>spec:	.version 
>then ?

Same problem, no rule to create .version.  This should work.

spec:
	[ -e .version ] || echo 1 > .version
	. scripts/mkspec >kernel.spec

