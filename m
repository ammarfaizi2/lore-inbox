Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278630AbRKAJpW>; Thu, 1 Nov 2001 04:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278632AbRKAJpC>; Thu, 1 Nov 2001 04:45:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28299 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S278630AbRKAJoz>;
	Thu, 1 Nov 2001 04:44:55 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hasch@t-online.de (Juergen Hasch)
To: linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?q?Lang=E5s?= <tlan@stud.ntnu.no>
Subject: Re: Intel EEPro 100 with kernel drivers
Date: Thu, 1 Nov 2001 10:43:36 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <15zDX1-1svMLQC@fwd03.sul.t-online.com> <20011101100637.B20259@stud.ntnu.no>
In-Reply-To: <20011101100637.B20259@stud.ntnu.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15zENy-0f1aOOC@fwd03.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. November 2001 10:06 schrieb Thomas Langås:
> Juergen Hasch:
>
> I'm testing now, however, running eepro100-diag gave me some interessting
> output:
>
> Sleep mode is enabled.  This is not recommended. Under high load the card
> may not respond to PCI requests, and thus cause a master abort.
>
> How do I disable sleepmode? I've never even enabled it.

The sleep bit is sometimes enabled by default (it was for me).
You can clear it with eepro100-diag (I think it was the -Gww option).

The documentation for eepro100-diag is somehow sparse, but
clearing the sleep bit was discussed on the eepro100 mailing list at 
scyld.com in great detail. You might want to browse the archives there.

...Juergen
