Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSHUFZ6>; Wed, 21 Aug 2002 01:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHUFZ6>; Wed, 21 Aug 2002 01:25:58 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:7835 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317872AbSHUFZ5>; Wed, 21 Aug 2002 01:25:57 -0400
Subject: RE: Alloc and lock down large amounts of memory
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense3d.com>
References: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense3d.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Aug 2002 08:29:52 +0300
Message-Id: <1029907792.19202.25.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 23:08, Bhavana Nagendra wrote:
> > 
> > Curiosity:  why do you want to do device DMA buffer 
> > allocation from userland?
> 
> Gilad, I looked at mm/memory.c and map_user_kiobuf() lets me
> map user memory into kernel memory and pins it down.  A scatter 
> gatter mapping (say, pci_map_sg()) will create a seemingly 
> contiguous buffer for DMA purposes.  Does that sound right to you?

Can your device actually use scatter gather (has 'virtual bus addresses'
or can get the buffer in several chunks?) Can the device actually DMA
all the memory in the system?

In short, I have no idea. :-)


Gilad.
-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

