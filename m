Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRHTWwQ>; Mon, 20 Aug 2001 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRHTWwG>; Mon, 20 Aug 2001 18:52:06 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:28397 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S269777AbRHTWvu>;
	Mon, 20 Aug 2001 18:51:50 -0400
Date: Mon, 20 Aug 2001 15:50:58 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM : PCI hotplug crashes with 2.4.9
To: Greg KH <greg@kroah.com>, Pierre JUHEN <pierre.juhen@wanadoo.fr>
Cc: mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Message-id: <08d401c129ca$94ebd2a0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr> <20010820123625.A31374@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Only the
> first line "pcimodules scanning 00:00.0" is displayed.

Curious.  If anything, I'd expect it to say
"pcimodules is scanning more than 00:00.0".
(The last version I saw didn't have a way to
scan for modules appropriate to a particular
PCI slot, and the hotplug scripts warn about
that limitation.)

You might try renaming "pcimodules" to "pcimodules-"
to see if that changes any interesting behavior.  I notice
you're using RedHat with 7.1 and usb-uhci.  I seem to
recall that Kudzu wanted to do some hotplug-ish things;
they may not play well together yet.

- Dave


