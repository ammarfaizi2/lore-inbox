Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSAILMC>; Wed, 9 Jan 2002 06:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSAILLz>; Wed, 9 Jan 2002 06:11:55 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14346 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289338AbSAILLk>; Wed, 9 Jan 2002 06:11:40 -0500
Date: Wed, 9 Jan 2002 12:11:37 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] RE: CML2-2.0.0 is available -- major release announcement
Message-ID: <20020109111137.GA5707@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31506DB462C@berkeley.gci.com> <3C3AACE0.8030408@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3C3AACE0.8030408@dplanet.ch>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2002, Giacomo Catenazzi wrote:

> >Missed SCSI_Generic
> >Missed Unix Domain Sockets!
> >Missed Packet Socket (based on running kernel)
> 
> 
> Hard to detect these 'software devices'.
> Some suggestions?

I'm totally ignorant on how your autoconfigure works, so this may be
blatantly wrong, take this cum granu salis:

+ Always add SCSI-Generic if there is any SCSI support is present.

+ Always enable unix domain sockets if networking is desired.

? As to the packet socket, I cannot tell, I always enable it on my
  configurations.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
