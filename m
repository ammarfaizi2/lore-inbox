Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSEVSlx>; Wed, 22 May 2002 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSEVSls>; Wed, 22 May 2002 14:41:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37311 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316674AbSEVSlp>;
	Wed, 22 May 2002 14:41:45 -0400
Date: Wed, 22 May 2002 11:38:23 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        William Lee Irwin III <wli@holomorphy.com>
cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <367710000.1022092703@flay>
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixing the application to use clone() not 4000 individual sets of page
> tables might not be a bad plan either.

Oracle !*#$(*^  #(*%^(#*^6  &@^@*  #^#*^  %#%.

> Do each of your tasks map the stuff at the same address. If you are 
> assuming this how do you plan to handle the person who doesn't. You won't
> be able to share page tables then ?

I think so. They're also hardlocked in memory which makes life easier.
 
> Can you even make that work -before- the customers have all upgraded
> anyway ?

Given that we're selling a new line of machines based on this now, I'd guess
it'll be 5 years before they're all upgraded. On the other hand, I think they'll
lynch us if Linux doesn't work properly on these type of machines within the
next year ;-) But, yes, I still think it's worth it. Hammer is a great promise, but
it's just not here right now, and I don't think we'll have production level 8-way
and 16-way machines for at least a year ... 

M.
