Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSANQsM>; Mon, 14 Jan 2002 11:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287615AbSANQqL>; Mon, 14 Jan 2002 11:46:11 -0500
Received: from [66.89.142.2] ([66.89.142.2]:35371 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S287658AbSANQo3>;
	Mon, 14 Jan 2002 11:44:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 10:24:20 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16PzHb-00006g-00@starship.berlin> <3C426819.982E5967@zip.com.au>
In-Reply-To: <3C426819.982E5967@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QAAG-0000mk-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 06:09 am, Andrew Morton wrote:
> Daniel Phillips wrote:
> I believe that internal preemption is
> the foundation to improve 2.5 kernel latency.  But first we need
> consensus that we *want* linux to be a low-latency kernel.
> 
> Do we have that?

You have it from me, for what it's worth ;-)

> If we do, then as I've said before, holding a lock for more than N
> milliseconds becomes a bug to be fixed.  We can put tools in the hands of 
> testers to locate those bugs.  Easy.

Perhaps not a bug, but bad-acting.  Just as putting a huge object on the 
stack is not necessarily a bug, but deserves a quick larting nonetheless.

--
Daniel
