Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRH3Rp6>; Thu, 30 Aug 2001 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272370AbRH3Rps>; Thu, 30 Aug 2001 13:45:48 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:51472 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S272369AbRH3Rpl>; Thu, 30 Aug 2001 13:45:41 -0400
Date: Thu, 30 Aug 2001 13:45:57 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: <mike_phillips@urscorp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <OF071248D9.F16220EF-ON85256AB8.0059A701@urscorp.com>
Message-ID: <Pine.LNX.4.33.0108301345260.9230-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 mike_phillips@urscorp.com wrote:

> > So I have this number, -200, which is stored in an int. I have this 
> other
> > number, 200, which is stored in an unsigned char. Everybody in his right
> > mind will agree that -200 is smaller than 200, the compiler will do just
> > that, yet you disagree???
> 
> Now try doing that with an int and an unsigned int, you'll get 200, not 
> -200.

You'll get a warning with -Wsign-compare, which is what the argument was 
all about.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

