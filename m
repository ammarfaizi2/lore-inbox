Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266036AbRF1QqM>; Thu, 28 Jun 2001 12:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266037AbRF1QqC>; Thu, 28 Jun 2001 12:46:02 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:53765
	"EHLO awak") by vger.kernel.org with ESMTP id <S266036AbRF1Qp5>;
	Thu, 28 Jun 2001 12:45:57 -0400
Subject: Re: 2.4.5-ac19: hang on IDE DVD read error
From: Xavier Bestel <xavier.bestel@free.fr>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: liste noyau linux <linux-kernel@vger.kernel.org>
In-Reply-To: <993744819.9219.12.camel@nomade>
In-Reply-To: <993744819.9219.12.camel@nomade>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 28 Jun 2001 18:41:39 +0200
Message-Id: <993746499.9219.13.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2001 18:13:38 +0200, Xavier Bestel wrote:
> Hi,
> 
> I retested my scratched DVD on 2.4.5-ac19, and the machine still hangs
> (when using drip) after spitting a few errors in the log:
> Jun 28 00:32:55 bip kernel: Info fld=0x1f49e0, Current sd0b:00: sense key Medium Error
> Jun 28 00:32:55 bip kernel: Additional sense indicates Unrecovered read error
> Jun 28 00:32:55 bip kernel:  I/O error: dev 0b:00, sector 8202112
> 
> As I'm under X, I had no chance to try Magic Sysreq. But machine doesn't
> respond on pings.
> A have a Dual PIII, via686b, Hitachi DVD-ROM GD-7500 on builtin IDE
> controler.
> I'm booting with 'noapic acpi=no-idle', more info on demand.

Oh, and I'm using ide-scsi to access my drive.

Xav

