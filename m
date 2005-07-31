Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263222AbVGaN7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263222AbVGaN7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGaN7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:59:04 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:10733 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S263222AbVGaN7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:59:02 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Wireless Security Lock driver.
Date: Sun, 31 Jul 2005 14:59:00 +0100
User-Agent: KMail/1.8.1
Cc: Brian Schau <brian@schau.com>, linux-kernel@vger.kernel.org
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz>
In-Reply-To: <20050730194215.GA9188@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507311459.00957.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 Jul 2005 20:42, Pavel Machek wrote:
> Hi!
>
> > I've attached a gzipped version of my Wireless Security Lock patch
> > for v2.6.13-rc4.
> > A Wireless Security Lock (WSL or weasel :-) is made up of two parts.
> > One part is a receiver which you plug into any available USB port.
> > The other part is a transmitter which at fixed intervals sends
> > "ping packets".
> > A "ping packet" usually consists of an ID and a flag telling if the
> > transmitter has just been turned on.
>
> Idea is good... but why don't you simply use bluetooth (built into
> many notebooks) and bluetooth-enabled phone?
>
> Probably could be done in userspace, too :-).

There's a script to this on the gentoo wiki via BlueZ.

http://gentoo-wiki.com/TIP_Bluetooth_Proximity_Monitor

I personally think the problem with this approach is that most phones have 
bluetooth enabled explicitly as an option, it doesn't run all the time, or 
default on. Primarily this is because bluetooth can drain your phone's 
battery (though, I don't know by how much, if you're not actually 
transferring data over it).

A CR2032 cell, in a specific piece of kit, is going to last for a lot longer 
than a phone battery.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
