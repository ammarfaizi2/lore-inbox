Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKMQpv>; Mon, 13 Nov 2000 11:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKMQpm>; Mon, 13 Nov 2000 11:45:42 -0500
Received: from ns.caldera.de ([212.34.180.1]:51717 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129130AbQKMQpX>;
	Mon, 13 Nov 2000 11:45:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14864.6812.849398.988598@ns.caldera.de>
Date: Mon, 13 Nov 2000 17:45:16 +0100 (CET)
To: Francis Galiegue <fg@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com>
In-Reply-To: <14864.5656.706778.275865@ns.caldera.de>
	<Pine.LNX.4.21.0011131744100.594-100000@toy.mandrakesoft.com>
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
From: Torsten Duwe <duwe@caldera.de>
Reply-to: Torsten.Duwe@caldera.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Francis" == Francis Galiegue <fg@mandrakesoft.com> writes:

    >> + if ((*p & 0xdf) >= 'a' && (*p & 0xdf) <= 'z') continue;

    Francis> Just in case... Some modules have uppercase letters too :)

That's what the &0xdf is intended for...

	Torsten
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
