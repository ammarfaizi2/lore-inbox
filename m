Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWIZAPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWIZAPC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbWIZAPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:15:01 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59128 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751844AbWIZAPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:15:00 -0400
Date: Mon, 25 Sep 2006 18:16:32 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Problem of using a PCI device in a Hot Plug PCI slot
In-reply-to: <fa.BsJcaoGiqHA64KagHwjdw2fLLJM@ifi.uio.no>
To: Igor Sharovar <ig_sh@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <45187160.10404@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.BsJcaoGiqHA64KagHwjdw2fLLJM@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Sharovar wrote:
> Hello,
> 
> A PCI card, which developed in my company, isn't powered in a Hot Plug 
> PCI slot(  Intel server ).
> During boot-up, a populated slot powers up, then immediately powers off.
> The card works fine in non Hot Plug slots. The Hot Plug PCI 
> specification says that a regular PCI card should at least be powered in 
> a Hot Plug PCI slot.
> What are requirements for running a PCI card in a Hot Plug slot.
> I would appreciate any help.

Maybe the card isn't grounding the right PRSNT pins to allow the machine 
to detect the presence of the card?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

