Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130879AbQK3Exr>; Wed, 29 Nov 2000 23:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130075AbQK3Evi>; Wed, 29 Nov 2000 23:51:38 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129983AbQK3Evh>;
        Wed, 29 Nov 2000 23:51:37 -0500
Message-ID: <139801c05a7c$65f76310$0a25a8c0@wizardess.wiz>
From: "J. Dow" <jdow@earthlink.net>
To: "Federico Grau" <donfede@casagrau.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20001129213933.A5309@casagrau.org>
Subject: Re: rocketport pci question... it stopped working after 250 days uptime
Date: Wed, 29 Nov 2000 19:19:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Federico Grau" <donfede@casagrau.org>

> We have several linux boxes useing 8 port rocketport pci multiport serial
> cards.  Earlier last week 3 of them stopped working within a 24 hour period.
> These three boxes had similar uptimes (since their last kernel rebuild); 249
> days, 248 days, 250 days.  Comparing the logs of each box, we saw that each
> box's rocketport stopped working after aproximately 248 days 16 hours uptime.

If it was 248 days 13 hours 13 minutes 56.48 seconds this represents a 32 bit
counter on a 5ms clock overflowing. I'd look for that in the RocketPort code.
Although I remember Jeff remarking about something else failing at about the
same uptime.

{^_^}    Joanne Dow, jdow@earthlink.net


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
