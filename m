Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281523AbRKMM2l>; Tue, 13 Nov 2001 07:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKMM2a>; Tue, 13 Nov 2001 07:28:30 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:8176 "EHLO
	c0mailgw01.prontomail.com") by vger.kernel.org with ESMTP
	id <S276369AbRKMM2T> convert rfc822-to-8bit; Tue, 13 Nov 2001 07:28:19 -0500
X-Version: beer 7.5.2333.0
From: "william fitzgerald" <william.fitzgerald3@beer.com>
Message-Id: <E2D08E27D008FC940A0E24ADA76AD89F@william.fitzgerald3.beer.com>
Date: Wed, 14 Nov 2001 12:33:02 +2400
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: pwaechtler@loewe-komp.de,
        william fitzgerald <william.fitzgerald3@beer.com>
Subject: Re: Re: printk performance logging without syslogd for router
CC: linux-kernel@vger.kernel.org
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---- Begin Original Message ----
 From: Peter Wächtler <pwaechtler@loewe-komp.de>
Sent: Tue, 13 Nov 2001 13:15:45 +0100
To: william fitzgerald
<william.fitzgerald3@beer.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printk performance logging without
syslogd for router


william fitzgerald wrote:
> 
> hi all,
> 
> (perforamnce logging of network stack through a
> linux router)
> 
> the main question:
> 
> is there a way i can buffer or record  the
printk
> statements and print them to disk  after my
> packets have gone through the router?
> 

there is an option in syslogd to prevent
immediatly
writing to the logfile:

prefix the log with a dash:

kern.*	-/var/log/kernelmessages

---- End Original Message ----

what does klogd do?

i thought klogd writes to disk if you turn off
syslogd.that way you only have one over head.




Beer Mail, brought to you by your friends at beer.com.
