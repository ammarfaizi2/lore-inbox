Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWAIG1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWAIG1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932811AbWAIG1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:27:01 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:2665 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932809AbWAIG07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:26:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Date: Mon, 9 Jan 2006 01:26:56 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Alan Stern <stern@rowland.harvard.edu>, Leonid <nouser@lpetrov.net>
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de> <E1Evi0c-0002mt-00@mars.bretschneidernet.de>
In-Reply-To: <E1Evi0c-0002mt-00@mars.bretschneidernet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601090126.56831.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 16:23, Martin Bretschneider wrote:
> Hello,
> 
> Jens Nödler who has got the same motheboard (Gigabyte GA-K8NF-9 with
> nforce4 chipset) can confirm my problem. But he found out that the
> keyboard connected to the ps/2 port does work with kernel 2.6.15 if
> "USB keyboard support" is disabled in the BIOS.
>

Ok, I an getting enough reports to conclude that the new usb-handoff
code does not seem to be working. Let's try CCing USB list and other
parties involved :)

Greg, Alan, any ideas?

-- 
Dmitry
