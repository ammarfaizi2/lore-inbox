Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318748AbSIEWjp>; Thu, 5 Sep 2002 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318749AbSIEWjp>; Thu, 5 Sep 2002 18:39:45 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:58026 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318748AbSIEWjo>;
	Thu, 5 Sep 2002 18:39:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>, "Peter T. Breuer" <ptb@it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
Date: Fri, 6 Sep 2002 00:45:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>,
       david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.SOL.3.96.1020904143824.7543A-100000@libra.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1020904143824.7543A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n5Nf-0006CE-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 16:13, Anton Altaparmakov wrote:
> Did you read my post which you can lookup on the below url?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103109165717636&w=2
> 
> That explains what a single byte write to an uncached ntfs volume entails.
> (I failed to mention there that you would actually need to read the block
> first modify the one byte and then write it back but if you write
> blocksize based chunks at once the RCW falls away.
> And as someone else pointed out I failed to mention that the entire
> operation would have to keep the entire fs locked.)
> 
> If it still isn't clear let me know and I will attempt to explain again in
> simpler terms...

Anton, it's clear he understands the concept, and doesn't care because
he does not intend his application to access the data a byte at a time.

Your points are correct, just not relevant to what he wants to do.

-- 
Daniel
