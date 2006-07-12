Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWGLSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWGLSJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGLSJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:09:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52160 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932273AbWGLSJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:09:12 -0400
Subject: Re: annoying frequent overcurrent messages.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, ray-gmail@madrabbit.org,
       Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20060712175124.GF14453@redhat.com>
References: <2c0942db0607121009l1fc00764ye0b98d686700a74c@mail.gmail.com>
	 <Pine.LNX.4.44L0.0607121314490.6111-100000@iolanthe.rowland.org>
	 <20060712175124.GF14453@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 19:26:25 +0100
Message-Id: <1152728785.22943.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 13:51 -0400, ysgrifennodd Dave Jones:
> Defective it may be, I'm not arguing that.    But spewing hundreds of
> these an hour isn't going to make the user fix the problem (if they even can)
> any faster.
> 
> *grumbles and goes to edit modprobe.conf*

dmidecode
pci svid/subdevice

submit patch

I agree entirely with the other Alan here, overcurrent is a serious item
with a potential severity not that far below "your cpu fan seems to have
stopped going round  [Ok]"


If its a dodgy board it should be possible to id and blacklist its UHCI
controller


