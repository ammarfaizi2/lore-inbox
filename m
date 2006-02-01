Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWBAPTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWBAPTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWBAPTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:19:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63702 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161088AbWBAPTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:19:51 -0500
Date: Wed, 1 Feb 2006 16:19:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mj@ucw.cz, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43DF65C8.nail3B41650J9@burner>
Message-ID: <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner>
 <mj+md-20060131.104748.24740.atrey@ucw.cz> <43DF65C8.nail3B41650J9@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Users like to be able to get a list of posible targets for a single protocol.
>> > Nobody would ever think about trying to prevent people from getting a unified
>> > view on the list possible hosts that talk TCP/IP.
>>
>> How do you perform -scanbus for TCP/IP? :-)
>
>There are various programs that do that for you.
>You could e.g. send a ping to the broadcast address in order to find hosts
>that are on the local network.

ping is ICMP/IP, therefore is not relevant to the question ;)
`nmap -sT` would probably do more TCP.

>If you understand this, why then insists other people in using names like 
>/dev/hd*?

It's shorter than /dev/c0t0d0s0? Well, I think it's because people think 
in terms of connectors (my drive is IDE therefore it must be hdc) rather 
than protocol (my drive does ATAPI therefore it must be 
/dev/scsi/c0t0d0s0).


Jan Engelhardt
-- 
