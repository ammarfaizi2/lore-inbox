Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293434AbSCEQbK>; Tue, 5 Mar 2002 11:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293425AbSCEQbB>; Tue, 5 Mar 2002 11:31:01 -0500
Received: from mailserver1.internap.com ([64.94.124.35]:47147 "EHLO
	mailserver1.internap.com") by vger.kernel.org with ESMTP
	id <S293424AbSCEQaw> convert rfc822-to-8bit; Tue, 5 Mar 2002 11:30:52 -0500
Date: Tue, 05 Mar 2002 08:30:48 -0800
From: Scott Laird <laird@internap.com>
To: =?ISO-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <2532693.1015317048@[0.0.0.0]>
In-Reply-To: <20020305153025.A12473@stud.ntnu.no>
In-Reply-To: <20020305.055204.44939648.davem@redhat.com>
 <20020305150204.A7174@stud.ntnu.no>
 <20020305.060323.99455532.davem@redhat.com>
 <20020305.060604.68157839.davem@redhat.com>
 <20020305153025.A12473@stud.ntnu.no>
X-Mailer: Mulberry/2.2.0b2 (Mac OS X Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, March 5, 2002 3:30 PM +0100 Thomas Langås 
<tlan@stud.ntnu.no> wrote:

> David S. Miller:
>> Most gigabit switches don't support 9000 byte mtu :-)
>
> Hmm, I found a document through google; Cisco Catalyst 4006 doesn't
> support 9KB MTUs, so I'll contact the networking guys and fix this,
> we want switches that supports large MTUs :)

Good luck; they're fairly rare.  From what I can tell, Cisco only 
supports jumbo frames on the Catalyst 5000 and 6000 families.  Extreme 
supports them on at least a few models.  The cheapest jumbo frame 
switch that I could find is the Intel 480T, which is over $7,000.

After doing a bunch of benchmarking, for our hardware and workload, 
jumbo frames don't really seem to help performance much anyway, so I 
ended up getting a $1,300 Dell 5012 (10 10/100/1000, 2 GBIC) switch.

I've heard rumors that Asante will have a jumbo-capable switch in May 
or so.  Since they seem to OEM the same hardware that Dell does (for 3x 
Dell's  cost), I wouldn't be too suprised to see a $1,500 16-port gig 
switch from Dell in a few months.


Scott
