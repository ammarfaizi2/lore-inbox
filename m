Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRIGFvd>; Fri, 7 Sep 2001 01:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271239AbRIGFvX>; Fri, 7 Sep 2001 01:51:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12810 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271230AbRIGFvL>; Fri, 7 Sep 2001 01:51:11 -0400
Message-ID: <3B986042.9050405@zytor.com>
Date: Thu, 06 Sep 2001 22:50:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip  aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com> <3B985FC6.B41000A3@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> That will always work, even when you have multiple ethernet
> interfaces??
> 

It better.  Otherwise you'd have the machine sending packets out one 
interface and in the other, and the two networks might not even be 
connected...

	-hpa

