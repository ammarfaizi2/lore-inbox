Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVGZM0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVGZM0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVGZM0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:26:45 -0400
Received: from web25810.mail.ukl.yahoo.com ([217.12.10.195]:41910 "HELO
	web25810.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261741AbVGZM0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:26:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JOvA7CT277OrCu5J7ueDBcKfiCkVwZORy3wri+zixllTkfhBIEZYTOTLU4kf55XE1QX9kjQFeYKp989t3KZalY1CA7GIcNu+HkwlOeOuUjVjAQ2rV6l1qeu6qrwc4HrfaIlGCT89gmgqfS/LNOWQRXernFD4+9ckOu37K6jWTUQ=  ;
Message-ID: <20050726122602.22799.qmail@web25810.mail.ukl.yahoo.com>
Date: Tue, 26 Jul 2005 14:26:02 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [INPUT] simple question on driver initialisation.
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050726120108.GA2101@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vojtech for your answers !

--- Vojtech Pavlik <vojtech@suse.cz> a écrit :

> It's also available via an ioctl() and in sysfs. This allows you to
> specify in an application that you want a device plugged into a specific
> port of the machine. Not many applications can use it at the moment, but
> udev can use it to assign a name of the device node.
> 

hmm, how can I use ioctl to find the location device since I need the location
to pass it to ioctl ?

I can't find "pinpad/input0" in sysfs, does that mean I need to add sysfs
suppport in my driver, and it's not done in input module when I register 
my input driver ?

> "pinpad/input0" doesn't sound right. What port is your pinpad connected
> to?
> 

Actually I'm working on an embedded system which owns a pinpad controller.
This controller is accessed by using io mem and it talks to the pinpad through
a dedicated bus. So I accessed it through io space.

thanks,

         Francis.


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
