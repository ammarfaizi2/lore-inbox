Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSHSQaJ>; Mon, 19 Aug 2002 12:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSHSQaI>; Mon, 19 Aug 2002 12:30:08 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18424 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318932AbSHSQaI>; Mon, 19 Aug 2002 12:30:08 -0400
Subject: Re: [linux-usb-devel] Linux 2.4.20pre3 breaks alsa 0.9.0.rc3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Howarth <howarth@bromo.med.uc.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200208191609.MAA27419@bromo.msbb.uc.edu>
References: <200208191609.MAA27419@bromo.msbb.uc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 17:33:22 +0100
Message-Id: <1029774802.19375.38.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 17:09, Jack Howarth wrote:
>    I haven't seen this mentioned yet but the new
> pre3 changes remove the typedef of urb_t and purb_t
> from include/linux/usb.h. This causes alas-drivers
> 0.9.0rc3 to fail to compile. I wanted to find out
> if this removal of urb_t and purb_t was 
> final or if it would be regressed back in pre4?

Its part of the 2.4/2.5 usb cleanup of dumb typedefs. You can probably
search-and-destroy them into the struct form with no problems

