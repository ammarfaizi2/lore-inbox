Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWIZUVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWIZUVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWIZUVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:21:51 -0400
Received: from bay0-omc3-s31.bay0.hotmail.com ([65.54.246.231]:5357 "EHLO
	bay0-omc3-s31.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S964781AbWIZUVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:21:50 -0400
Message-ID: <BAY103-F365FA452C152C9CF32478385250@phx.gbl>
X-Originating-IP: [66.46.92.242]
X-Originating-Email: [ig_sh@hotmail.com]
In-Reply-To: <45187160.10404@shaw.ca>
From: "Igor Sharovar" <ig_sh@hotmail.com>
To: hancockr@shaw.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem of using a PCI device in a Hot Plug PCI slot
Date: Tue, 26 Sep 2006 16:21:48 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 26 Sep 2006 20:21:50.0327 (UTC) FILETIME=[65FA6870:01C6E1A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,
I checked these pins. They are grounded.
I wonder if a Hot Plug slot doesn't have enough power to feed the card. I 
measured voltages (12, 3.3 and 5). I saw a spark during power on, but this 
spark never goes to a normal voltage level. For example, in the +12v pin I 
saw a spark +3.5 volt.

Igor


>From: Robert Hancock <hancockr@shaw.ca>
>To: Igor Sharovar <ig_sh@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Problem of using a PCI device in a Hot Plug PCI slot
>Date: Mon, 25 Sep 2006 18:16:32 -0600
>
>Igor Sharovar wrote:
>>Hello,
>>
>>A PCI card, which developed in my company, isn't powered in a Hot Plug PCI 
>>slot(  Intel server ).
>>During boot-up, a populated slot powers up, then immediately powers off.
>>The card works fine in non Hot Plug slots. The Hot Plug PCI specification 
>>says that a regular PCI card should at least be powered in a Hot Plug PCI 
>>slot.
>>What are requirements for running a PCI card in a Hot Plug slot.
>>I would appreciate any help.
>
>Maybe the card isn't grounding the right PRSNT pins to allow the machine to 
>detect the presence of the card?
>
>--
>Robert Hancock      Saskatoon, SK, Canada
>To email, remove "nospam" from hancockr@nospamshaw.ca
>Home Page: http://www.roberthancock.com/
>

_________________________________________________________________
Buy what you want when you want it on Sympatico / MSN Shopping 
http://shopping.sympatico.msn.ca/content/shp/?ctId=2,ptnrid=176,ptnrdata=081805

