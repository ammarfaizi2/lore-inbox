Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313326AbSDOWjl>; Mon, 15 Apr 2002 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313339AbSDOWjk>; Mon, 15 Apr 2002 18:39:40 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:16617 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313326AbSDOWjj>;
	Mon, 15 Apr 2002 18:39:39 -0400
Date: Tue, 16 Apr 2002 00:39:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Maxwell Spangler <maxwax@mindspring.com>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
Message-ID: <20020416003931.A31385@ucw.cz>
In-Reply-To: <E16xA96-0002Ru-00@roos.tartu-labor> <Pine.LNX.4.44.0204151804100.1145-100000@tyan.doghouse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 06:04:54PM -0400, Maxwell Spangler wrote:
> On Mon, 15 Apr 2002, Meelis Roos wrote:
> 
> > MH> Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
> > MH> ide_setup: idebus=66
> > MH> ide: system bus speed 66MHz
> > 
> > MH> works like a charm :)
> > 
> > Do you really have an IDE controller that does 66 MHz PCI? What kind on IDE
> > controller is this?
> 
> I have a Promise Ultra133TX2 card on my shelf that is 32-bit PCI with 66Mhz 
> operation.
> 
> I don't know to what extent it is supported yet.. Andre?

The promise driver ignores the idebus= value anyway. :) And for others
66 is usually an invalid setting.

-- 
Vojtech Pavlik
SuSE Labs
