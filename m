Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbRERIbE>; Fri, 18 May 2001 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262280AbRERIay>; Fri, 18 May 2001 04:30:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2827 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262279AbRERIap>; Fri, 18 May 2001 04:30:45 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: tim@tjansen.de (Tim Jansen)
Date: Fri, 18 May 2001 09:27:42 +0100 (BST)
Cc: bdwheele@wombat.educ.indiana.edu (Brian Wheeler),
        linux-kernel@vger.kernel.org
In-Reply-To: <01051810241601.00782@cookie> from "Tim Jansen" at May 18, 2001 10:24:16 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150fbq-0006qZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Consider an ID consisting of:
> > 	* vendor
> > 	* model
> 
> Vendor and model ids are available for PCI and USB devices, but I think you 
> can not assume that all busses have them and you dont gain anything if you 
> keep them separate (unless you want to interpret the fields of the device id).
> In other words I would merge them into a single field.

Well you actually want vendor,model, subvendor, submodel to cover PCI, and
you can add ISAPnP and PnPBIOS to your list of suitable devices


