Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311209AbSCPXqI>; Sat, 16 Mar 2002 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311210AbSCPXpt>; Sat, 16 Mar 2002 18:45:49 -0500
Received: from diale112.ppp.lrz-muenchen.de ([129.187.28.112]:42761 "HELO
	Nicole.fhm.edu") by vger.kernel.org with SMTP id <S311209AbSCPXpn>;
	Sat, 16 Mar 2002 18:45:43 -0500
Subject: Re: [Lse-tech] 7.52 second kernel compile
From: Daniel Egger <degger@fhm.edu>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <730219199.1016271418@[10.10.2.3]>
In-Reply-To: <20020316061535.GA16653@krispykreme> 
	<730219199.1016271418@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 16 Mar 2002 19:57:32 +0100
Message-Id: <1016305054.19498.13.camel@sonja>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sam, 2002-03-16 um 18.37 schrieb Martin J. Bligh:

> BTW - the other tip that was in the big book of whizzy kernel
> compiles was to set gcc to use -pipe ... you might want to try
> that.

Interestingly -pipe doesn't give any measurable performance increases or
even leads to a minor decrease in compile speed in my latest tests on
bigger projects like the linux kernel or GIMP. I suspect that's because
of the caching nature of nowadays systems: the temporary products are
cached in memory and likely not to never end on a drive because they're
read and removed before the point the filesystem decides to physically
write the data.

I also benchmarked tmpfs mounts and it demonstrated - to my surprise -
small advantages slightly above the noise range; I suspect this is due
to the way it handles files in memory.
 
-- 
Servus,
       Daniel

