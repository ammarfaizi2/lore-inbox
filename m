Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTGPSHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270977AbTGPSFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:05:43 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:10507 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S271040AbTGPSDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:03:40 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: Input layer demand loading
Date: Wed, 16 Jul 2003 22:19:17 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307162219.17067.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> True, but then if you try to open the port, you will only get the base
>> joydev.o module loaded, not the gameport driver, which is what you
>> _really_ want to have loaded, right?
>> 
>> So there really isn't much benifit to doing this, sorry.
>
> Why? It could work the way PCMCIA SCSI works.
> Cardmgr loads the LLDD, but sd, sg, etc. are loaded
> on demand.

how? SCSI (or USB, PCI, EISA etc) have driver-independent means to identify 
device or at least device class.

But how are you going you going to know you need to load specific mouse driver 
(logitech not microsoft) or specific joystick flavour? All that you possibly 
know that you have _some_ mouse or _some_ joystick ...

-andrey
