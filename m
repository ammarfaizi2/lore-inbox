Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbTH0DOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 23:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTH0DOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 23:14:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263042AbTH0DOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 23:14:38 -0400
Message-ID: <3F4C2210.6050404@pobox.com>
Date: Tue, 26 Aug 2003 23:14:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Urbanik <nicku@vtc.edu.hk>
CC: andersen@codepoet.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
References: <20030722184532.GA2321@codepoet.org>	 <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>	 <20030722205629.GA27179@gtf.org> <20030722213926.GA4295@codepoet.org> <3F4C1F09.846A83EF@vtc.edu.hk>
In-Reply-To: <3F4C1F09.846A83EF@vtc.edu.hk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Urbanik wrote:
> Dear Erik and Jeff,
> 
> Did you make any progress here or were you discouraged by the resulting
> flamewar?

hehe... flamewars rarely discourage me :)


> Does this work in 2.4.x?  I have a Tyan Trinity i875P S5101 which I want to
> use the parallel IDE ports on.  They are connected to a PDC20378.  Any
> patches that you think would be reliable?  Or should I take the opportunity
> to return this to the vendor and buy an Intel S845WD1-E instead?

Well, the GPL'd Promise driver that was posted will work.

For the future, I'm currently whipping the libata internals into shape 
so that Promise may be supported.  Promise hardware supports native 
command queueing, a lot like many SCSI adapters.

	Jeff



