Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUCBQ4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUCBQ4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:56:23 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:37579 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S261708AbUCBQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:55:07 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics and USB mouse conflict at boot time !?
Date: Tue, 2 Mar 2004 17:56:16 +0100
User-Agent: KMail/1.5.4
References: <200403021103.54310.AlberT@SuperAlberT.it> <200403020640.30354.dtor_core@ameritech.net>
In-Reply-To: <200403020640.30354.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200403021756.17443.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:40, martedì 2 marzo 2004, Dmitry Torokhov wrote:
> On Tuesday 02 March 2004 05:03 am, Emiliano 'AlberT' Gabrielli wrote:
> > Hi all,
> > 	 I have a strange behaviour on my laptop: touchpad is not probed by the
> > kernel (2.6.3) *if* and only if at boot time the USB mouse is plugged in
> > ...
>
> It is usually caused by USB Legacy emulation - BIOS makes a USB mouse look
> like a PS/2 mouse. Look in your BIOS setup if there is an option to turn it
> off. Otherwise you will have to load ehci/uhci_hcd and hid modules before
> loading psmouse module as loading full-blown USB support disables that
> emulation.


perfect, now all works fine
thank you so much


BTW, can be usefull to add this tip in the "help" screen of input/mice and/or 
usb

-- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>

