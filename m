Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRJTSwu>; Sat, 20 Oct 2001 14:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRJTSwk>; Sat, 20 Oct 2001 14:52:40 -0400
Received: from dsl027-178-158.sfo1.dsl.speakeasy.net ([216.27.178.158]:37760
	"HELO whiskey.synfin.net") by vger.kernel.org with SMTP
	id <S273888AbRJTSwh>; Sat, 20 Oct 2001 14:52:37 -0400
Date: Sat, 20 Oct 2001 11:50:21 -0700 (PDT)
From: "Aaron D. Turner" <aturner@whiskey.synfin.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.13pre5 breaks usb-storage ?
Message-ID: <Pine.LNX.4.33.0110201149570.3045-100000@whiskey.synfin.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've been playing with a USB pendrive.  Worked great under 2.4.13pre3, but
now under pre5, the system will not recognize it and not autoload
usb-storage.  Also, if the input event module (evdev) is loaded, and you 
manually load usb-storage, it hangs your terminal.  After a while I get 
the error:

Oct 19 18:06:32 whiskey kernel: uhci.c: uhci_transfer_result: called for 
URB c1c69b60 not in flight?

This is happening on two different systems, an IBM 600X and Athalon based 
system (both using the uhci driver).

Once I go back to 2.4.13pre3, the problem goes away...

-- 
Aaron



