Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131040AbRAaLoM>; Wed, 31 Jan 2001 06:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRAaLoC>; Wed, 31 Jan 2001 06:44:02 -0500
Received: from styx.suse.cz ([195.70.145.226]:17149 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131040AbRAaLnt>;
	Wed, 31 Jan 2001 06:43:49 -0500
Date: Wed, 31 Jan 2001 12:43:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: safemode <safemode@voicenet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010131124345.A1407@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com> <20010131083642.A964@suse.cz> <20010130235525.A7513@fortyoz.org> <3A77DF79.2C1F5A7@voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A77DF79.2C1F5A7@voicenet.com>; from safemode@voicenet.com on Wed, Jan 31, 2001 at 04:48:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 04:48:41AM -0500, safemode wrote:

> From what I gather this chipset on 2.4.x is only stable if you
> cripple just about everything that makes
> it worth having (udma, 2nd ide channel  etc etc)  ?    does it even
> work when all that's done now or is it fully functional?

For most people (95% at least) it's fully functional, including DMA
(even UDMA100), both channels (I have never seen a problem with the 2nd
channel?), etc. There are some people who have problems, namely Abit KT7
users, but a BIOS upgrade seems to fix those case usually.

> I used some pre 2.4.1 kernel before it thrashed my disk and i had UDMA
> disabled in bios and kernel and the corruption persisted.  I heard
> somewhere that it may have been linked to swap ?     Anyway, I'm using
> 2.2.19-pre7 right now with DMA and it's doing perfect ...with better
> responsiveness than 2.4.x .  Could this be because of via problems on
> the 2.4.x kernel or is it 2.4.x arch ?

No, probably not.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
