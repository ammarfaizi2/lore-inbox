Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274918AbTGaXPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274915AbTGaXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:14:58 -0400
Received: from mail1.kontent.de ([81.88.34.36]:12709 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S274867AbTGaXMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:12:41 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Date: Fri, 1 Aug 2003 01:12:20 +0200
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059689105.2417.195.camel@gaston> <20030731220958.GA459@elf.ucw.cz>
In-Reply-To: <20030731220958.GA459@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308010112.20514.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Is not disk spin-down policy, and thus belonging to userspace? Having
> daemon poll for inactivity of hubs once every 5 minutes and sending
> them to sleep should not hurt, too...
> 								Pavel

Taking precedents into account it is the kernel's job.
Screen blanking is done in kernel, as is afaik floppy
motor control.

	Regards
		Oliver

