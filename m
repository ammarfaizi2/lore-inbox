Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTEZFX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTEZFX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:23:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19605 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264271AbTEZFX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:23:27 -0400
Message-ID: <3ED1A7DB.1000507@pobox.com>
Date: Mon, 26 May 2003 01:36:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305252214290.6692-100000@home.transmeta.com> <3ED1A664.1020307@pobox.com>
In-Reply-To: <3ED1A664.1020307@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> So, I conclude:  faster, smaller, and better future direction.  IMO, of 
> course :)


As a FWIW, this driver is mainly intended as a Serial ATA driver.

It just happens to do PATA by coincedence (i.e. because it makes devel 
easier for me).

For example, current Intel SATA is "PATA, but without the timing junk."

I think with SATA + drivers/ide, you reach a point of diminishing 
returns versus amount of time spent on mid-layer coding.

	Jeff



