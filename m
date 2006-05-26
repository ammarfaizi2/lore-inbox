Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWEZLKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWEZLKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWEZLKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:10:03 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:31690 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751398AbWEZLKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:10:00 -0400
Message-ID: <4476E203.1080701@pobox.com>
Date: Fri, 26 May 2006 07:09:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <44764D4B.6050105@pobox.com> <4476D63E.8090207@gmail.com> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com> <4476DA5C.9080602@pobox.com> <4476DE47.7010907@gmail.com>
In-Reply-To: <4476DE47.7010907@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jeff Garzik napsal(a):
>> The point is that you don't need to loop over the table,
>> pci_match_one_device() does that for you.
> The problem is, that there is no such function, I think.
> If you take a look at pci_dev_present:

The function you want is pci_dev_present().

	Jeff



