Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKNU5a>; Wed, 14 Nov 2001 15:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRKNU5U>; Wed, 14 Nov 2001 15:57:20 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:11762 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277541AbRKNU5I>; Wed, 14 Nov 2001 15:57:08 -0500
Date: Wed, 14 Nov 2001 12:50:48 -0800
From: Chris Wright <chris@wirex.com>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT broken in stock 2.4.13
Message-ID: <20011114125048.A32600@figure1.int.wirex.com>
Mail-Followup-To: Terje Eggestad <terje.eggestad@scali.no>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1005747508.1310.3.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1005747508.1310.3.camel@pc-16.office.scali.no>; from terje.eggestad@scali.no on Wed, Nov 14, 2001 at 03:18:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Terje Eggestad (terje.eggestad@scali.no) wrote:
> Hi 
> 
> open( , O_DIRECT) succeds, fcntl set and unset of the O_DIRECT flag is
> ok, but I get buffered writes anyway. 
> 
> This works in 2.4.10 

iirc, this was disabled shortly after 2.4.10 (like 2.4.11-pre1 or 2).
i believe the flag is still valid, however, i think the direct_io internals 
were removed.

cheers,
-chris
