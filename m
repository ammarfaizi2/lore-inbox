Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbTEBQKv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbTEBQKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:10:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63900
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262974AbTEBQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:10:50 -0400
Subject: Re: [PATCH 0/4] NE2000 driver updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jeff Muizelaar <muizelaar@rogers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB29566.4000903@pobox.com>
References: <3EB15127.2060409@rogers.com>
	 <1051817031.21546.23.camel@dhcp22.swansea.linux.org.uk>
	 <3EB1ADEC.6080007@rogers.com>
	 <1051884070.23249.4.camel@dhcp22.swansea.linux.org.uk>
	 <3EB29566.4000903@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051889074.23255.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 May 2003 16:24:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-02 at 16:57, Jeff Garzik wrote:
> even willing to spend a few (admittedly costly) extra cycles chasing 
> some additional function pointer de-refs, if we could massively shrink 
> the size and number of NE2000/lance/82596 drivers out there.

Well the 8390 (ne2000 etc) has been abstracted cleanly for a very long
time indeed. 825xx is a pig because they chip variants are all subtly
and evilly different.

> I guarantee these drivers are gonna be with us for many years to come, 
> and designers wanting to bang out a quick-and-easy MAC will create Yet 
> Another NE2000 Clone.[1]

They seem to be cloning tulip nowdays

> Did I mention that a GIGE ne2000 card exists?

I've got a 100Mbit one.

Alan

