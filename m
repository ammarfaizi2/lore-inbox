Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWAWVrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWAWVrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWAWVrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:47:43 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:18191 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S964903AbWAWVrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:47:43 -0500
Date: Mon, 23 Jan 2006 22:47:24 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060123214724.GA17760@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060122074034.GA1315@epio.fluido.as> <20060121235546.68f50bd5.akpm@osdl.org> <200601231101.25268.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200601231101.25268.david-b@pacbell.net>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: lun 23 gen 06 11:01:25 -0800

Quoting David Brownell (david-b@pacbell.net):

> Maybe this time it'd help to tell your BIOS "yes, DO use USB".

That I am doing. And I now have the appropriate OHCI module
loaded. USB 1.1 works apparently quite OK. 

> Or, the attached patch might help.  

I applied the patch. The three changes to the second file applied with
an offset of 6 lines (to 2.6.15 vanilla). Nothing changed: the booting
process hung at the same place, generating the same printout as
before. I have now booted the new kernel with EHCI disabled, and saved
the dmesg oputput to http://www.fluido.as/files/dmesg2.txt (here,
USB1.1 is active).

It is time for sleep for me. I will perform any new test tomorrow
morning.

Carlo


-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
