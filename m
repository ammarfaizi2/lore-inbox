Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSASUuU>; Sat, 19 Jan 2002 15:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSASUuK>; Sat, 19 Jan 2002 15:50:10 -0500
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:64909 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S287287AbSASUtx>; Sat, 19 Jan 2002 15:49:53 -0500
Message-ID: <000e01c1a12a$d9c9e470$1400870a@joulu>
From: "Jani Forssell" <jani.forssell@viasys.com>
To: "Ville Herva" <vherva@niksula.hut.fi>
Cc: <linux-kernel@vger.kernel.org>, "Tim Moore" <timothymoore@bigfoot.com>
In-Reply-To: <00c201c1a033$1cf46700$b71c64c2@viasys.com> <3C48BF64.FBF58C7C@bigfoot.com> <20020119110143.GB135220@niksula.cs.hut.fi>
Subject: Re: VIA KT133 & HPT 370 IDE disk corruption
Date: Sat, 19 Jan 2002 22:49:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that culprit wasn't the slot that shares an irq with the highpoint
> controllers (HPT370 on this board). We knew to avoid that slow from the
> beginning (I have a BP6 at home), but I think we tried slot 5 out of
> interest after we had verified slot 3 works. I think slot 5 showed the
> problem as well - Jani?

That's right, when the NIC was in slot 4, 5 or 6, it oopsed almost
immediately when both the drives on HPT370 IDE and the NIC 
were stressed simultaneously. 

Jani Forssell


