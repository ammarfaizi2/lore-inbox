Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUJNOWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUJNOWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUJNOWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:22:49 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:63630 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S265051AbUJNOWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:22:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16750.35738.230789.561852@gargle.gargle.HOWL>
Date: Thu, 14 Oct 2004 10:22:18 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Ganesan R <rganesan@myrealbox.com>
Cc: John Stoffel <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, torsten.scherer@uni-bielefeld.de
Subject: Re: Linux 2.6.x wrongly recognizes USB 2.0 DVD writer
In-Reply-To: <416E7E39.4040102@myrealbox.com>
References: <ckln33$c3e$1@sea.gmane.org>
	<16750.30914.666243.108593@gargle.gargle.HOWL>
	<416E7E39.4040102@myrealbox.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ganesan> Thanks for the info. As I mentioned, the enclosure works
Ganesan> flawlessly for me under 2.4.27. It's getting detected
Ganesan> incorrectly only in 2.6.x.  Another user reported a similar
Ganesan> problem but was able to get dvd burning working by removing
Ganesan> the checks from the writing tool. So, it looks like detection
Ganesan> has been messed up only in 2.6.x.

I'm an idiot.  I mis-read your initial post thinking it was like my
ByteCC which has the dual Firewire/USB ports and since I can't get
EITHER interface type to work reliablely, I've given up on it for now.

What's the output of 'lsusb'?  You want to see what the vendor/product
ID is as a comparison.  I should check mine again under USB and see
what happens under 2.6.8, though earlier it would just hang the entire
system after copying a GB or two of data.  At least under FireWire
when it hung, I could recover the system without having to reboot.

Gah... time for more caffeine.
