Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSBOT1s>; Fri, 15 Feb 2002 14:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290679AbSBOT10>; Fri, 15 Feb 2002 14:27:26 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:45996 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290677AbSBOT1R>; Fri, 15 Feb 2002 14:27:17 -0500
Message-ID: <3C6D607F.80109@wanadoo.fr>
Date: Fri, 15 Feb 2002 20:24:47 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
In-Reply-To: <Pine.LNX.4.33.0202151019590.829-100000@segfault.osdlab.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
 > On Fri, 15 Feb 2002, Patrick Mochel wrote:
 >
 >
 >>> no, it doesn't solve the problem. i would like to test it whith 
preemtible
 >>> kernel not set but it doesn't boot.
 >>>
 >> While Greg's patch did fix part of the problem, the rest of it was
 >> on my end. Could you try this patch, and see if helps?
 >>
 >
 > Actually, the patch that I sent is against my current tree, which
 > includes some changes that I've already pushed to Linus. If you're
 > using BK, you should be able to pull his current tree (if you're
 > into that kinda thing). Or, wait until -pre2. Sorry about that.

well, it looks like my driverfs/inode.c has 20 lines or so more than
yours, but *it works* (together with Greg's patch on usb.c).

good work

Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

