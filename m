Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbSJDPrM>; Fri, 4 Oct 2002 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSJDPrL>; Fri, 4 Oct 2002 11:47:11 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:21010 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S262108AbSJDPrK>; Fri, 4 Oct 2002 11:47:10 -0400
Date: Sat, 5 Oct 2002 01:52:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 and Netgear GA302T  x 2 locks machine
In-Reply-To: <3D9D21D6.4090306@candelatech.com>
Message-ID: <Mutt.LNX.4.44.0210050151050.21370-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Ben Greear wrote:

> Changed the PCI slot of eth2 to a 32-bit slot, and now it works
> better...
> 
> It passed packets for about 20 seconds, then spit out a bunch of these:
> 

Which kernel version?  There was a lockup problem for the GA302T just 
after NAPI went in (which was fixed soon after).


- James
-- 
James Morris
<jmorris@intercode.com.au>


