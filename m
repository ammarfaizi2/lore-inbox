Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTIWASw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTIWASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:18:08 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:2759 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262807AbTIWAR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 20:17:58 -0400
Subject: Re: Can we kill f inb_p, outb_p and other random I/O on port 0x80,
	in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: John Bradford <john@grabjohn.com>, arjanv@redhat.com,
       ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030922213732.GC29869@mail.jlokier.co.uk>
References: <200309222003.h8MK38kC000353@81-2-122-30.bradfords.org.uk>
	 <20030922213732.GC29869@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064276178.9807.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 23 Sep 2003 01:16:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 22:37, Jamie Lokier wrote:
> At the moment, outb_p followed by inb will be seen by the ISA device
> as "write, write, read," giving the ISA device time to propagate state
> changes between the end of the first write and the beginning of the
> read.

This isnt MMIO so won't be posted.

