Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRIBXZT>; Sun, 2 Sep 2001 19:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270319AbRIBXY7>; Sun, 2 Sep 2001 19:24:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S270314AbRIBXYz>;
	Sun, 2 Sep 2001 19:24:55 -0400
Date: Mon, 3 Sep 2001 00:25:14 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, thunder7@xs4all.nl, parisc-linux@lists.parisc-linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk> <20010902.160441.92583890.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010902.160441.92583890.davem@redhat.com>; from davem@redhat.com on Sun, Sep 02, 2001 at 04:04:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 04:04:41PM -0700, David S. Miller wrote:
>    From: Matthew Wilcox <willy@debian.org>
>    Date: Sun, 2 Sep 2001 15:00:23 +0100
> 
>    On Sun, Sep 02, 2001 at 10:55:38AM +0200, thunder7@xs4all.nl wrote:
>    > ReiserFS version 3.6.25
>    > bonnie[163]: Unaligned data reference 28
>    
>    As it says, an unaligned data reference.
>    
> BTW, you should not be OOPSing on this as unaligned references are
> defined as completely normal, especially in the networking.
> 
> Is it impossible to handle unaligned access traps properly on
> parisc?  If so, well you have some problems...

No, we just haven't bothered to implement it yet.  Not many people
use IPX these days.

-- 
Revolutions do not require corporate support.
