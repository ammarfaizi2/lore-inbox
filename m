Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVAGSjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVAGSjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVAGSjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:39:42 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:15375 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261424AbVAGSjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:39:40 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Antonio de Candia <decandia@na.infn.it>, linux-kernel@vger.kernel.org
Subject: Re: Tyan Thunder K7X Pro Ethernet Card
Date: Fri, 7 Jan 2005 20:39:29 +0200
User-Agent: KMail/1.5.4
References: <200501031244.58929.decandia@na.infn.it>
In-Reply-To: <200501031244.58929.decandia@na.infn.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501072039.29962.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 January 2005 13:44, Antonio de Candia wrote:
> Hallo,
> 
> I have an APPRO node with Tyan Thunder K7X Pro (S2469)
> motherboard.
> It has two onboard Ethernet controllers, 
>     - Intel® 82545EM 10/100/1000Mbps controller
>     - Intel® 82551QM 10/100Mbps controller
> (as stated on www.tyan.de)
> I installed Linux Slackware 10.0, and used the modules
> e1000 and e100 for the two ethernet cards...
> The first eth0 works well with the e1000 driver, but 
> eth1 with e100 does not work... if I scp a big file,
> after transmitting some megabytes it hangs (scp says
> "-- stalled --")
> The same happens with http transfers...
> I tried also with eepro100 driver, but nothing changes...

Anything in the logs? What does "tcpdump -nlieth1" show?
Does it survive floodpinging? Large HTTP downloads?
Do HTTP downloads from nearby box have expected throughput?
etc...
--
vda

