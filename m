Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267198AbSLEDLC>; Wed, 4 Dec 2002 22:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbSLEDLB>; Wed, 4 Dec 2002 22:11:01 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:16260 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267198AbSLEDLB>; Wed, 4 Dec 2002 22:11:01 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <20021205004744.GB2741@zax.zax>
	<200212050144.gB51iH105366@localhost.localdomain>
	<20021205023847.GA1500@zax.zax>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 12:17:55 +0900
In-Reply-To: <20021205023847.GA1500@zax.zax>
Message-ID: <buohedtrw64.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> writes:
> It seems the "try to get consistent memory, but otherwise give me
> inconsistent" is only useful on machines which:
> 	(1) Are not fully consisent, BUT
> 	(2) Can get consistent memory without disabling the cache, BUT
> 	(3) Not very much of it, so you might run out.
> 
> The point is, there has to be an advantage to using consistent memory
> if it is available AND the possibility of it not being available.
...
> Are there actually any machines with the properties described above?

As I mentioned in my previous message, one of my platforms is like that
-- PCI consistent memory must be allocated from a special pool of
memory, which is only 2 megabytes in size.

-Miles
-- 
`Life is a boundless sea of bitterness'
