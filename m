Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQKIAut>; Wed, 8 Nov 2000 19:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKIAui>; Wed, 8 Nov 2000 19:50:38 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:17202 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129033AbQKIAu3>; Wed, 8 Nov 2000 19:50:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14857.62696.393621.795132@somanetworks.com>
Date: Wed, 8 Nov 2000 19:50:48 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: David Ford <david@linux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
In-Reply-To: <3A09F158.910C925@linux.com>
In-Reply-To: <3A09F158.910C925@linux.com>
X-Mailer: VM 6.75 under 21.2  (beta35) "Nike" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DF" == David Ford <david@linux.com> writes:

 DF> Ok, in test10, for every 2 out of 5 boots, this particular
 DF> workstation locks up hard as it reaches the following:

I have a similar problem.  My work around is to, by hand, modprobe
usbmouse, wait, modprobe usb-uhci...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
