Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271830AbRH2Bdn>; Tue, 28 Aug 2001 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRH2Bdd>; Tue, 28 Aug 2001 21:33:33 -0400
Received: from [209.202.108.240] ([209.202.108.240]:57099 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S271830AbRH2BdV>; Tue, 28 Aug 2001 21:33:21 -0400
Date: Tue, 28 Aug 2001 21:33:25 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <Pine.LNX.4.33.0108282124170.22653-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What if:

1) We rename the new min() as type_min(),
2) We bring back the old min(), and
      HERE is the _important_ part:
3) Have min() bitch and moan real loud whenever the two arguments
       aren't of the same type.

That way we can have it both ways: a min() that is easy and convenient, and a
min() that can handle two arguments with different types.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>




