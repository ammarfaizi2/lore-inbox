Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281617AbRKMMQJ>; Tue, 13 Nov 2001 07:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281620AbRKMMP7>; Tue, 13 Nov 2001 07:15:59 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:63750 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S281617AbRKMMPv>; Tue, 13 Nov 2001 07:15:51 -0500
Message-ID: <3BF10EF1.FD4075B6@loewe-komp.de>
Date: Tue, 13 Nov 2001 13:15:45 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: william fitzgerald <william.fitzgerald3@beer.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printk performance logging without syslogd for router
In-Reply-To: <6169641FA9FA29E43946AEB269F1EA2E@william.fitzgerald3.beer.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

william fitzgerald wrote:
> 
> hi all,
> 
> (perforamnce logging of network stack through a
> linux router)
> 
> the main question:
> 
> is there a way i can buffer or record  the printk
> statements and print them to disk  after my
> packets have gone through the router?
> 

there is an option in syslogd to prevent immediatly
writing to the logfile:

prefix the log with a dash:

kern.*	-/var/log/kernelmessages
