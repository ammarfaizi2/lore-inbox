Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUDSMzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbUDSMzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:55:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12300 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264392AbUDSMzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:55:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "John Que" <qwejohn@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NIC inerrupt
Date: Mon, 19 Apr 2004 15:54:19 +0300
X-Mailer: KMail [version 1.4]
References: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
In-Reply-To: <BAY14-F34eqdGSyMp690005e9f6@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200404191554.19942.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 April 2004 15:46, John Que wrote:
> Hello,
>
> I want to count the number of times I reach an NIC receive
> interrupt.
>
> I added a global static variable of type int , and initialized
> it to 0 ; each time I am in the rx_interrupt of the card I incerement
> it by one;
> I got large , non sensible numbers after one or two seconds;
>
> So  for debug I added printk each time I increment it in rx_interrupt.
>
> What I see is that there are  unreasonable jumps in the number
>
> for instance , it inceremnts sequntially from 1 to 80,then jums to 4500,
> increments a little sequentially to 4580, and the jums again to
> 11000 ;
>
> Is it got to do with it that this is in interrupt?
> Any idea what it can be ?
>
>
> (I also tried to declare it as static in the rx_interrupt method
> and the same happened)

Show your code
-- 
vda
