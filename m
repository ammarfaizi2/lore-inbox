Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270133AbRIBXFC>; Sun, 2 Sep 2001 19:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270154AbRIBXEw>; Sun, 2 Sep 2001 19:04:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20358 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270133AbRIBXEe>;
	Sun, 2 Sep 2001 19:04:34 -0400
Date: Sun, 02 Sep 2001 16:04:41 -0700 (PDT)
Message-Id: <20010902.160441.92583890.davem@redhat.com>
To: willy@debian.org
Cc: thunder7@xs4all.nl, parisc-linux@lists.parisc-linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on
 parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere>
	<20010902150023.U5126@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Sun, 2 Sep 2001 15:00:23 +0100

   On Sun, Sep 02, 2001 at 10:55:38AM +0200, thunder7@xs4all.nl wrote:
   > ReiserFS version 3.6.25
   > bonnie[163]: Unaligned data reference 28
   
   As it says, an unaligned data reference.
   
BTW, you should not be OOPSing on this as unaligned references are
defined as completely normal, especially in the networking.

Is it impossible to handle unaligned access traps properly on
parisc?  If so, well you have some problems...

Later,
David S. Miller
davem@redhat.com
