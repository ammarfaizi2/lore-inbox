Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130166AbRCBAFx>; Thu, 1 Mar 2001 19:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRCBAFf>; Thu, 1 Mar 2001 19:05:35 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:10769
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130166AbRCBAF2>; Thu, 1 Mar 2001 19:05:28 -0500
Date: Thu, 1 Mar 2001 16:04:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Tim Walberg <tewalberg@mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: smartmedia adapter support??
In-Reply-To: <20010301100041.A22824@mediaone.net>
Message-ID: <Pine.LNX.4.10.10103011600490.10136-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Tim Walberg wrote:

> Just wondering whether anyone has successfully gotten
> either a PCMCIA SmartMedia Adapter (specifically the
> Viking Components one) or a FlashPath floppy SmartMedia
> adapter working under 2.4.x. I've got both, and haven't
> gotten either working under either 2.2.x or 2.4.x, but
> I haven't had the time to work real hard at it either,
> so I'm hoping someone can give me some pointers...

That is going to be a SDA device and will have another form of content
protection like CPRM and Linux will not support that superset of features
at this time or in the future.  SMA's are on the hit list for music by the
SDMI.  If you want to use it as as standard ATA device cool, but the
0xD{0123} opt-codes are not public yet and fall under CFA.

Because it does not use a public spec and I can not release the private
one.....well you get the point.

Regards,

Andre Hedrick
Linux ATA Development

