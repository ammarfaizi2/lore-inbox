Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTHCGlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 02:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTHCGlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 02:41:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271026AbTHCGls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 02:41:48 -0400
Message-ID: <3F2CAE9D.5090401@pobox.com>
Date: Sun, 03 Aug 2003 02:41:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Shih <alan@storlinksemi.com>
CC: Ben Greear <greearb@candelatech.com>, Nivedita Singhvi <niv@us.ibm.com>,
       Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <ODEIIOAOPGGCDIKEOPILKEKKDAAA.alan@storlinksemi.com>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILKEKKDAAA.alan@storlinksemi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Shih wrote:
> A DMA xfer that fills the NIC pipe with IDE source. That's not very hard...
> need a lot of bufferring/FIFO though.  May require large modification to the
> file serving applications?


Nope, that's using the existing sendfile(2) facility.

	Jeff



