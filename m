Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271655AbRHUNwG>; Tue, 21 Aug 2001 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271667AbRHUNv4>; Tue, 21 Aug 2001 09:51:56 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:3060 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271655AbRHUNvs>;
	Tue, 21 Aug 2001 09:51:48 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010821.055856.08326920.davem@redhat.com> <d3elq5a6au.fsf@lxplus015.cern.ch> <20010821.063900.112292626.davem@redhat.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 Aug 2001 15:51:55 +0200
In-Reply-To: "David S. Miller"'s message of "Tue, 21 Aug 2001 06:39:00 -0700 (PDT)"
Message-ID: <d3wv3x8qro.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David>    From: Jes Sorensen <jes@sunsite.dk> Date: 21 Aug 2001
David> 15:31:05 +0200
   
>    Alan did after I pointed out to him that it was incompatible
> with the GPL (BSD license with advertisement clause). Really
> hard to fix unless you get QLogic to change the license for
> you.

David> And what about the Qlogic,ISP firmware in the tree too?  Those
David> have no copyright notice, but I think this is due to omission.
David> The same identical firmware code in Matt Jacob's
David> isp_dist.tar.gz driver has the BSD license at the top of every
David> firmware file.

I have no idea where that firmware comes from. Since QLogic has in
fact re-released some of their firmware images under the GPL I have no
reason to believe images without copyright messages are in violation
of the BSD license.

If you have evidence that the isp driver ships with firmware thats in
violation of the GPL, then please remove it as well.

David> You might as well remove all of these drivers in whole, as they
David> are basically non-functional without the accompanying firmware.

So you are suggesting that we keep violating the GPL in order to help
out people nuking their own flash by mistake?

The much cleaner way to solve this problem is to write a user space
tool to upgrade the image in the flash ram on the QL with your latest
favorite image found at www.qlogic.com. It's a 128KB image, you can
write directly to the flash in two banks by setting the read/write bit
and setting the 2nd bank bit for the last 64KB.

Jes
