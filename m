Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261470AbTDBECG>; Tue, 1 Apr 2003 23:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbTDBECG>; Tue, 1 Apr 2003 23:02:06 -0500
Received: from ns.conceptual.net.au ([203.190.192.15]:30933 "EHLO
	conceptual.net.au") by vger.kernel.org with ESMTP
	id <S261470AbTDBECF>; Tue, 1 Apr 2003 23:02:05 -0500
Message-ID: <3E8A6298.8060600@seme.com.au>
Date: Wed, 02 Apr 2003 12:10:00 +0800
From: Brad Campbell <brad@seme.com.au>
User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
References: <3E88FA24.7040406@seme.com.au> <20030401042734.GA21273@gtf.org> <3E89171A.8010506@seme.com.au> <20030401185258.GC3736@arthur.home>
In-Reply-To: <20030401185258.GC3736@arthur.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SFilter: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

> 
> Here's the 2.5 driver backported to 2.4.20, it solved my timeout
> problems (with thanks to Roger Luethi). Don't know if the "noapic"
> option is still necessary, but it won't hurt anyway.
> 
> 
> Erik
Yup, Roger sent me the file directly (Many thanks Roger!)
It solved the timeout propblems, I do get these however.

Not that they cause any hiccups in throughput.

eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 40.
eth0: Tx descriptor write-back race.
eth0: Transmit error, Tx status 00008800.
eth0: Transmitter underrun, Tx threshold now 60.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.
eth0: Tx descriptor write-back race.


-- 
Brad....
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X      AGAINST HTML MAIL
  / \

