Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUF2HBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUF2HBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 03:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265516AbUF2HBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 03:01:43 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:64650 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265531AbUF2HBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 03:01:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/19] New set of input patches
Date: Tue, 29 Jun 2004 02:01:28 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20040628145454.9403.qmail@web81305.mail.yahoo.com> <20040628150736.GA1059@ucw.cz>
In-Reply-To: <20040628150736.GA1059@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406290201.28433.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 June 2004 10:07 am, Vojtech Pavlik wrote:
> On Mon, Jun 28, 2004 at 07:54:53AM -0700, Dmitry Torokhov wrote:
> > 
> > Sysfs changes should be useable even without platform device changes
> > and I would like start syncing with you. Would you take patches 2 
> > through 10 (I will drop the legacy_position stuff)?
>  
> Yes.
> 

Vojtech,

As we discussed I dropped the legacy_position sysfs attribute and moved
patches 2 through 10 to my repository on bkbits.net. I also moved patch
#14 because sa1111ps2, gscps2, ambakmi and pcips2 have already been 
integrated with sysfs so linking their serio ports to their devices
are simple one-liners not depending on anything I sent to Greg.

Please do:

	bk pull bk://dtor.bkbits.net/input

-- 
Dmitry
