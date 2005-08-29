Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVH2QNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVH2QNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVH2QNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:13:18 -0400
Received: from iris.datenpark.ch ([212.55.203.206]:3527 "HELO
	mail.qwasartech.com") by vger.kernel.org with SMTP id S1751257AbVH2QLx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:53 -0400
Message-ID: <431333C2.8080304@qwasartech.com>
Date: Mon, 29 Aug 2005 18:11:46 +0200
From: Dominik Wezel <dio@qwasartech.com>
Organization: Qwasartech
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB EHCI Problem with Low Speed Devices
 on kernel 2.6.11+
References: <Pine.LNX.4.44L0.0508272256010.24489-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0508272256010.24489-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan

> It looks to me more like a timing problem with initialization of the
> external high-speed hub.  Try this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112439094723976&w=2

Thank you very much: the patch seems indeed to fix the problem. 
However, I didn't boot more than twice with the new kernel now, and in a 
setup with unsystematic behaviour, such a small series of successes may 
mean nothing.

You'll hear from me though in either case after a larger series of 
boots. =:)

-- 

Dominik
