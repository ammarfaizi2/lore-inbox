Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272603AbTG1Ayz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272619AbTG1Ayi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:54:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272603AbTG1AyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 20:54:22 -0400
Message-ID: <3F2477C4.2000105@pobox.com>
Date: Sun, 27 Jul 2003 21:09:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew de Quincey <adq_dvb@lidskialf.net>
CC: Rahul Karnik <rahul@genebrew.com>,
       Marcelo Penna Guerra <eu@marcelopenna.org>,
       lkml <linux-kernel@vger.kernel.org>, Laurens <masterpe@xs4all.nl>
Subject: Re: [PATCH] nvidia nforce 1.0-261 nvnet for kernel 2.5
References: <200307262309.20074.adq_dvb@lidskialf.net> <200307271222.13649.adq_dvb@lidskialf.net> <3F23BC1D.7070804@genebrew.com> <200307271301.41660.adq_dvb@lidskialf.net>
In-Reply-To: <200307271301.41660.adq_dvb@lidskialf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One can set the MAC address manually via ifconfig.

So, try modprobing amd8111e with the nforce pci ids, then manually 
setting the MAC address, and see if that works.

(just make sure the MAC address you make up is unique)

	Jeff



