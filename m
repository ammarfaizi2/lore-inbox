Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280915AbRKGTLQ>; Wed, 7 Nov 2001 14:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280917AbRKGTK6>; Wed, 7 Nov 2001 14:10:58 -0500
Received: from hermes.toad.net ([162.33.130.251]:9641 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280915AbRKGTKn>;
	Wed, 7 Nov 2001 14:10:43 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
From: Thomas Hood <jdthood@mail.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BE841C4.947416CB@t-online.de>
In-Reply-To: <Pine.LNX.4.33.0111051219080.29021-100000@druid.if.uj.edu.pl> 
	<3BE841C4.947416CB@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1005152337.20875.76.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Evolution/0.15 (Preview Release)
Date: 07 Nov 2001 14:09:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 15:02, Gunther Mayer wrote:
> Solution:
> ---------
> PnPBIOS in linux should _not_ reserve these 2 ports (this kind of
> solution is commonly called a quirks).

That would work.  However the more appropriate solution would
seem to be for the floppy driver not to try to reserve them,
since it doesn't use them, and (judging from what you say)
on some machines they have nothing to do with the floppy
drive.

