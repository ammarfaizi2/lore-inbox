Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290755AbSAaAAL>; Wed, 30 Jan 2002 19:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290757AbSAaAAC>; Wed, 30 Jan 2002 19:00:02 -0500
Received: from colin.muc.de ([193.149.48.1]:52490 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S290755AbSA3X7v>;
	Wed, 30 Jan 2002 18:59:51 -0500
Message-ID: <20020131005937.56612@colin.muc.de>
Date: Thu, 31 Jan 2002 00:59:37 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Slab cache name fixes / reiserfs boot bug fix.
In-Reply-To: <20020131002937.A1372@averell> <Pine.LNX.4.33.0201301548100.14950-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.33.0201301548100.14950-100000@penguin.transmeta.com>; from Linus Torvalds on Thu, Jan 31, 2002 at 12:52:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:52:45AM +0100, Linus Torvalds wrote:
> 
> which is just simpler and doesn't have issues like fixed 16-byte arrays
> etc.

I did it this way to keep the stuff cache neutral (keep the names or pointer
to names out of the critical cache lines), but if you prefer the merged 
version I'll do that in a jiffie. 

-Andi
