Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUAIMSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 07:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUAIMSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 07:18:38 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:23714 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S261193AbUAIMSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 07:18:36 -0500
X-Sender-Authentication: net64
Date: Fri, 9 Jan 2004 13:18:12 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jonathan Lundell <jlundell@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-Id: <20040109131812.11fc4948.skraw@ithnet.com>
In-Reply-To: <p0602045cbc23ac7a1ada@[192.168.0.3]>
References: <20040107200556.0d553c40.skraw@ithnet.com>
	<20040107210255.GA545@alpha.home.local>
	<3FFCC430.4060804@candelatech.com>
	<20040108091441.3ff81b53.skraw@ithnet.com>
	<20040108084758.GB9050@alpha.home.local>
	<p0602042fbc2347a37845@[192.168.0.3]>
	<20040109004525.GB545@alpha.home.local>
	<p0602045cbc23ac7a1ada@[192.168.0.3]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004 17:00:42 -0800
Jonathan Lundell <jlundell@lundell-bros.com> wrote:

> At 1:45am +0100 1/9/04, Willy Tarreau wrote:
> >  > It's unfortunate that the two conditions are conflated by most net
> >  > drivers.
> >
> >IMHO, saying "most net drivers" is unfair : tg3, tulip, 3c59x, starfire,
> >realtek, sis900, dl2k, pcnet32, and IIRC sunhme are OK. eepro100 is nearly
> >OK but has this annoying bug, and only older 10 Mbps drivers don't report
> >their status, often because the chip itself doesn't know.
> 
> I'm sure you're right; I should have said most of the drivers that 
> I'm using (including e100 &e1000).

Can we find the cause for this obviously buggy behaviour inside the source? 
Where is the handling of physical up/down events different in tulip compared to
e100(0) ?

Regards,
Stephan


