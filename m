Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAETZc>; Fri, 5 Jan 2001 14:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAETZW>; Fri, 5 Jan 2001 14:25:22 -0500
Received: from ikar.t17.ds.pwr.wroc.pl ([156.17.210.253]:44038 "HELO
	ikar.t17.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S129183AbRAETZE>; Fri, 5 Jan 2001 14:25:04 -0500
Date: Fri, 5 Jan 2001 19:22:39 +0100
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
To: linux-kernel@vger.kernel.org
Subject: Re: reset_xmit_timer errors with 2.4.0
Message-ID: <20010105192239.A9051@ikar.t17.ds.pwr.wroc.pl>
In-Reply-To: <20010105065251.A8690@pr.es.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105065251.A8690@pr.es.to>; from modus-linux-kernel@pr.es.to on Fri, Jan 05, 2001 at 06:52:52AM -0800
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
X-Operating-System: Linux dark 4.0.20 #119 Tue Jan 16 12:21:53 MET 2001 i986 pld
X-Team: Polish Linux Distribution Team Member
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On/Dnia Fri, Jan 05, 2001 at 06:52:52AM -0800, Patrick Michael Kane wrote/napisa³(a)
> With 2.4.0 installed, I've started to see the following errors:
> 
> reset_xmit_timer sk=cfd889a0 1 when=0x3b4a, caller=c01e0748
> reset_xmit_timer sk=cfd889a0 1 when=0x3a80, caller=c01e0748
>
the same problem here + a lot of:
inet6_ifa_finish_destroy
inet6_ifa_finish_destroy
inet6_ifa_finish_destroy
messages from kernel.

> It's a UP system with no kernel patches, running an eepro100 card.
RTL-8029(AS) here but I guess that bug is somwhere else not at eth layer/level.

> Patrick Michael Kane

-- 
Arkadiusz Mi¶kiewicz, AM2-6BONE    [ PLD GNU/Linux IPv6 ]
http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/   [ enabled ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
