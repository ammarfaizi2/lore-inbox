Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130561AbQK1DoY>; Mon, 27 Nov 2000 22:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130643AbQK1DoO>; Mon, 27 Nov 2000 22:44:14 -0500
Received: from hera.cwi.nl ([192.16.191.1]:9653 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S130561AbQK1DoL>;
        Mon, 27 Nov 2000 22:44:11 -0500
Date: Tue, 28 Nov 2000 04:14:09 +0100
From: Andries Brouwer <aeb@veritas.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: console not working in linux
Message-ID: <20001128041409.A9525@veritas.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <8vubeq$r5r$1@cesium.transmeta.com> <20001127202738.A25168@vana.vc.cvut.cz> <20001128023652.A9368@veritas.com> <8vv2fa$7n6$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8vv2fa$7n6$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 27, 2000 at 05:40:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 05:40:58PM -0800, H. Peter Anvin wrote:

> > What about adding an additional
> > 
> > 	andb	$0xfe, %al
> > 
> > in front of the outb?

> Already in test12-pre1.

Ach, I see I am too slow - had not even seen -pre1 and now Linus
already announces -pre2.

Anyway, I considered that this A20 stuff belonged to my docs on
the keyboard controller, so added a page

	http://www.win.tue.nl/~aeb/linux/kbd/A20.html

(written half an hour ago). Comments are welcome.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
