Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129414AbQK2LGB>; Wed, 29 Nov 2000 06:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129449AbQK2LFw>; Wed, 29 Nov 2000 06:05:52 -0500
Received: from 62-6-231-191.btconnect.com ([62.6.231.191]:8964 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129414AbQK2LFh>;
        Wed, 29 Nov 2000 06:05:37 -0500
Date: Wed, 29 Nov 2000 10:37:10 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: 36bit mtrrs work! (2.4.0-test12-pre3)
Message-ID: <Pine.LNX.4.21.0011291035290.841-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just to let people know that 2.4.0-test12-pre3 behaves much better than
earlier versions on my 6G RAM machine. Not only /proc/mtrr is correctly
showing all 6G cached for write-back but also I so far I never had to
up/down one of the eepro100 interfaces to get it to work -- something I
hda to do in all previous versions. (without david-mtrr.patch)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
