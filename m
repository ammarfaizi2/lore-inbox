Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270108AbUJUKnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270108AbUJUKnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbUJUKmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:42:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14812 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270664AbUJUKij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:38:39 -0400
Subject: RE: forcing PS/2 USB emulation off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Greg KH <greg@kroah.com>, Alexandre Oliva <aoliva@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3017FC327@scl-exch2k.phoenix.com>
References: <5F106036E3D97448B673ED7AA8B2B6B3017FC327@scl-exch2k.phoenix.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098351305.17095.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 10:35:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 00:22, Aleksey Gorelov wrote:
> Isn't this interrupt disabled at that point, and status are cleared
> right
> after handoff ? Have you actually been able to see a problem with such 
> an interrupt with this patch applied ?

I've seen one Nvidia case where flipping the USB over caused an
immediate IRQ on that line.


