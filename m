Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285178AbRLRVRy>; Tue, 18 Dec 2001 16:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285179AbRLRVQW>; Tue, 18 Dec 2001 16:16:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30469 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285180AbRLRVPf>; Tue, 18 Dec 2001 16:15:35 -0500
Date: Tue, 18 Dec 2001 21:14:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, Mika.Liljeberg@welho.com, Mika.Liljeberg@nokia.com,
        linux-kernel@vger.kernel.org, sarolaht@cs.helsinki.fi
Subject: Re: ARM: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
Message-ID: <20011218211450.E13126@flint.arm.linux.org.uk>
In-Reply-To: <3C1FA558.E889A00D@welho.com> <200112182029.XAA11287@ms2.inr.ac.ru> <20011218210332.D13126@flint.arm.linux.org.uk> <20011218.131155.91757544.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218.131155.91757544.davem@redhat.com>; from davem@redhat.com on Tue, Dec 18, 2001 at 01:11:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 01:11:55PM -0800, David S. Miller wrote:
>    On Tue, Dec 18, 2001 at 11:29:06PM +0300, kuznet@ms2.inr.ac.ru wrote:
>    > No doubts it still has broken misaligned access.
>    
>    You're way out of line with that comment.
> 
> Not necessarily Russell.  You have even told us on several occaisions
> that the older ARMs simply cannot fix up unaligned loads/stores in
> fact.

It read as "Oh, it's ARM, that's your problem then".

> Look, we're analyzing a problem and trying to explore every avenue
> for possible problems.  If this were sparc64 I'd be checking my
> unaligned handler for bugs :-)

Well, as its already been established, its not running Linux, so it's not
my problem. 8)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

