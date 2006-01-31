Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWAaSVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWAaSVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAaSVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:21:37 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:15884 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1751321AbWAaSVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:21:36 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org, sander@humilis.net
Subject: Re: [OT] 8-port AHCI SATA Controller?
Date: Tue, 31 Jan 2006 09:19:19 -0900
User-Agent: KMail/1.7.2
Cc: jgarzik@pobox.com
References: <20060131115343.GA2580@favonius>
In-Reply-To: <20060131115343.GA2580@favonius>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310919.20199.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 02:53, Sander wrote:
> Hello,
>
> I'm looking for an 8-port SATA controller based on the AHCI chipset, as
> according to http://linux.yyz.us/sata/sata-status.html#vendor_support
> this chipset is completely open.
>
> I've searched the websides of the companies which according to
> http://linux.yyz.us/sata/sata-status.html#ahci base some of their
> products on this chipset, but I couldn't find an 8-port controller.
>
> I've also googled, but without success, hence this somewhat offtopic
> message. Although I hope the response helps others in their quest.
>
> The question: does an 8-port AHCI based SATA controller exist? And if,
> where can I find it? 12, 16 or 24 ports will do too. I don't need HW
> raid, just JBOD.

I've run some tests with this card under Linux and done pretty well:

http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm

They also have a 3.0Gb version.

Not sure if that is AHCI, but it is eight port.

I got the drivers here:

http://www.keffective.com/mvsata/FC3/

The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.

Hope that helps.

j----- k-----


-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
