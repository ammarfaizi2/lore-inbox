Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278538AbRJXOsd>; Wed, 24 Oct 2001 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRJXOsY>; Wed, 24 Oct 2001 10:48:24 -0400
Received: from news.cistron.nl ([195.64.68.38]:2832 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S275449AbRJXOsQ>;
	Wed, 24 Oct 2001 10:48:16 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Two suggestions (loop and owner's of linux tree)
Date: Wed, 24 Oct 2001 14:48:51 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9r6kcj$trt$3@ncc1701.cistron.net>
In-Reply-To: <1003933278.1496.6.camel@LNX.iNES.RO> <20011024143850.EAC2598410@oceanic.wsisiz.edu.pl>
X-Trace: ncc1701.cistron.net 1003934931 30589 195.64.65.67 (24 Oct 2001 14:48:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011024143850.EAC2598410@oceanic.wsisiz.edu.pl>,
Lukasz Trabinski  <lukasz@wsisiz.edu.pl> wrote:
>In article <1003933278.1496.6.camel@LNX.iNES.RO> you wrote:
>> chmod -R root.root linux/ 
>> after you have unpacked the tarball.
>
>Unnecessarily extra command :) Sometimes I can forget about this and then
>user with uid 1046 can modify my kernel source.

Simply unpack and compile the kernel as a normal user, not as root.
Only install the new kernel as root. Get into the habit of logging
in as a normal user and doing root stuff with 'su' or 'sudo'

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

