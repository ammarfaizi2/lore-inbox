Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSDSPQh>; Fri, 19 Apr 2002 11:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSDSPQg>; Fri, 19 Apr 2002 11:16:36 -0400
Received: from smtp01do.de.uu.net ([192.76.144.61]:3267 "EHLO
	smtp01do.de.uu.net") by vger.kernel.org with ESMTP
	id <S312574AbSDSPQf> convert rfc822-to-8bit; Fri, 19 Apr 2002 11:16:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tobias Wollgam <tobias.wollgam@materna.de>
Organization: Materna GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables
Date: Fri, 19 Apr 2002 17:16:25 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0204190851490.8537-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Encoded: Changed encoding from 8bit for 7bit transmission
Message-Id: <20020419151625.75F1167F6@penelope.materna.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 19 Apr 2002, Jamie Lokier wrote:
> > Since we're comparing sort algorithms, I am quite fond of Heapsort.
> > Simple, no recursion or stack, and worst case O(n log n).  It's not
> > especially fast, but the worst case behaviour is nice:

There exist a variation of heapsort called clever heapsort  (or 
bottom-up heapsort) that is a little bit faster for big arrays.

I don't know if it will be useful for the kernel. How big are the 
arrays?

Greetings,

	Tobias


-- 
Tobias Wollgam * Softwaredevelopment * Business Unit Information 
MATERNA GmbH Information & Communications
Vosskuhle 37 * 44141 Dortmund  
http://www.materna.de
