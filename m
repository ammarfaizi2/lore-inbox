Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbQL1U4I>; Thu, 28 Dec 2000 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQL1Uz6>; Thu, 28 Dec 2000 15:55:58 -0500
Received: from nat-hdqt.valinux.com ([198.186.202.17]:4666 "EHLO
	earth.su.valinux.com") by vger.kernel.org with ESMTP
	id <S129835AbQL1Uzr>; Thu, 28 Dec 2000 15:55:47 -0500
Date: Thu, 28 Dec 2000 13:33:10 -0800
From: Dragan Stancevic <visitor@valinux.com>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New discoveries in the EEPro100 init saga
Message-ID: <20001228133310.B31635@valinux.com>
In-Reply-To: <3A446A49.C1E7AAFB@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A446A49.C1E7AAFB@Hell.WH8.TU-Dresden.De>; from Udo A. Steinberg on Sat, Dec 23, 2000 at 10:03:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2000, Udo A. Steinberg <sorisor@Hell.WH8.TU-Dresden.De> wrote:
; 
; Hi all,
; 
; After enabling the option "EEPRO100_PM" and upgrading to test13-pre4
; my problems with the eepro100 driver mysteriously ceased to exist.
; I no longer see any "Card reports no RX buffers" or "Card reports no
; resources" messages.
; 
; Since I don't think -pre4 changed anything from -pre3 that would
; affect the eepro100 driver, my bet is that enabling the experimental
; power management feature somehow works around the issue.
; 
; Can others who've had similar problems check if that works for them
; as well? If it does, it should be somewhat simple to work out what
; the problem actually is, because the PM code is just a couple dozen
; lines.

Udo,

the driver has an issue that is affected by fiddling with different
parameters, it's a timing issue of somesort, changing a bit of code
seems to fix it on one system but it breaks it on others, I am comparing
the driver line by line to the specs to see where the misbehavioure
could be comming from.


-- 
I knew I was alone, I was scared, it was getting dark and
it was a hardware problem.

                                                -Dragan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
