Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133086AbRDVAeU>; Sat, 21 Apr 2001 20:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbRDVAeK>; Sat, 21 Apr 2001 20:34:10 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:49426 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133086AbRDVAd5>;
	Sat, 21 Apr 2001 20:33:57 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104220033.f3M0XsM162528@saturn.cs.uml.edu>
Subject: Re: Request for comment -- a better attribution system
To: babydr@baby-dragons.com (Mr. James W. Laferriere)
Date: Sat, 21 Apr 2001 20:33:53 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), esr@thyrsus.com,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.32.0104211456540.4237-100000@filesrv1.baby-dragons.com> from "Mr. James W. Laferriere" at Apr 21, 2001 02:59:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James  W. Laferriere writes:
> On Sat, 21 Apr 2001, Albert D. Cahalan wrote:
>> Eric S. Raymond writes:

>>> This is a proposal for an attribution metadata system in the Linux
>>> kernel sources.  The goal of the system is to make it easy for
>>> people reading any given piece of code to identify the responsible
>>> maintainer.  The motivation for this proposal is that the present
>>> system, a single top-level MAINTAINERS file, doesn't seem to be
>>> scaling well.
>>
>> It is nice to have a single file for grep. With the proposed
>> changes one would sometimes need to grep every file.
>
> 	Find . -name "*Some-Name*" -type f -print | xargs grep 'Some-Info'
> 	Hate answering with just one line of credible info , But .

The above would grep every file. It takes 1 minute and 9.5 seconds.
So the distributed maintainer information does not scale well at all.

