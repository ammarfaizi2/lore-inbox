Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSF0NEu>; Thu, 27 Jun 2002 09:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSF0NEs>; Thu, 27 Jun 2002 09:04:48 -0400
Received: from [193.14.93.89] ([193.14.93.89]:29700 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S316840AbSF0NEh>;
	Thu, 27 Jun 2002 09:04:37 -0400
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCx200 audio support?
References: <200206271443.35524.roy@karlsbakk.net>
From: Christer Weinigel <wingel@acolyte.hack.org>
Date: 27 Jun 2002 15:04:35 +0200
In-Reply-To: Roy Sigurd Karlsbakk's message of "Thu, 27 Jun 2002 14:43:35 +0200"
Message-ID: <m3d6uc98kc.fsf@acolyte.hack.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

> Any plans to support the National Geode SC1200 integrated audio chipset?
> 
> 00:12.3 Multimedia audio controller: National Semiconductor
> Corporation SCx200 Audio

The VSA BIOS should emulate a soundblaster card, so the normal
soundblaster driver ought to work.  There is also a native National
GX1+CS5530 driver that you can get from National and that driver ought
to work on the SC1200 although you might have to add the proper PCI
IDs.

     /Christer

-- 
"Just how much can I get away with and still go to heaven?"
