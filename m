Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbRG3LZd>; Mon, 30 Jul 2001 07:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268509AbRG3LZX>; Mon, 30 Jul 2001 07:25:23 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:22800 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268503AbRG3LZK>;
	Mon, 30 Jul 2001 07:25:10 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac3 
In-Reply-To: Your message of "Mon, 30 Jul 2001 12:16:20 +0100."
             <E15RB24-0003Xb-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 21:25:12 +1000
Message-ID: <23269.996492312@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 12:16:20 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> -spec:
>> +spec:	newversion
>>  	. scripts/mkspec >kernel.spec
>
>I only need a new version for a new rpm

mkspec requires .version, the only rule that creates .version is
newversion.  If you start from make mrproper, make spec fails.

