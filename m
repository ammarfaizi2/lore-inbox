Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287563AbSANQWh>; Mon, 14 Jan 2002 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287578AbSANQW3>; Mon, 14 Jan 2002 11:22:29 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:14343 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S287612AbSANQWP>; Mon, 14 Jan 2002 11:22:15 -0500
Message-ID: <3C430580.90309@zk3.dec.com>
Date: Mon, 14 Jan 2002 11:21:20 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
Subject: Re: FC & MULTIPATH !? (any hope?)
In-Reply-To: <20020114123301.B30997@danielle.hinet.hr> <20020114130720.J917@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:

 > On 2002-01-14T12:33:01, Mario Mikocevic <mozgy@hinet.hr> said:
 >
 >
 >> is there any hope of working combination of MULTIPATH with FC !?
 >>
 >
 > Yes. QLogic's newest 2200 HBA can do that. I don't know whether that
 >  is a possible solution for your problem though.
 >
The real question is when will Linux fully support multipath at the 
CAM/block layer? I'd really like to be able to throw, say, four HBAs 
into my system and have it use all of them simultaneously and not have 
to spend all sorts of time trying to set up all 200+ LUNs that I have 
available to me by hand.  Think 200 LUNs presented * 4 HBAs * 4 paths at 
the controller end per LUN.  That's quite a bit of setup to me.

  - Pete



