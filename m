Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbWLZM5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWLZM5c (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 07:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWLZM5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 07:57:32 -0500
Received: from lucidpixels.com ([66.45.37.187]:37077 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566AbWLZM5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 07:57:31 -0500
Date: Tue, 26 Dec 2006 07:57:29 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.17.13: eth2: TX underrun, threshold adjusted.
In-Reply-To: <45908F87.9010205@shaw.ca>
Message-ID: <Pine.LNX.4.64.0612260757120.10234@p34.internal.lan>
References: <fa.8x7CSG3Vz8/rASmsmG0lScp7gAc@ifi.uio.no> <45908F87.9010205@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2006, Robert Hancock wrote:

> Justin Piszcz wrote:
> > I am using a dual port Intel NIC on an A-Bit IC7-G; any reason why I get
> > these?
> > 
> > [4298634.444000] eth2: TX underrun, threshold adjusted.
> > [4299146.645000] eth2: TX underrun, threshold adjusted.
> 
> ...
> 
> > I am using the e100 driver, MAC addr commented out with **.
> > 
> > [4294675.208000] eth2: 0000:04:04.0, 00:**:**:**:**:**, IRQ 18.
> > [4294675.209000]   Receiver lock-up bug exists -- enabling work-around.
> > [4294675.209000]   Board assembly 711269-003, Physical connectors present:
> > RJ45
> 
> I don't think you are using e100, these messages seem to be from eepro100, not
> e100. Try disabling eepro100 and see if e100 works.
> 
> -- 
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 

Oops-- thanks, e100 has not produced the error yet.

Justin.
