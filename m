Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUBIQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 11:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBIQ5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 11:57:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35463 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265268AbUBIQ5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 11:57:15 -0500
Message-ID: <4027BBDE.1090300@pobox.com>
Date: Mon, 09 Feb 2004 11:57:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Horsten <thomas@horsten.com>
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
References: <Pine.LNX.4.40.0402091220130.8715-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0402091220130.8715-100000@jehova.dsm.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Horsten wrote:
> My gut feeling is that if it is provided by the BIOS and reliable
> autodetection is possible, it should be autodetected. Why require the user
> to discover and supply information that the kernel could easily and
> reliably find out by itself? Besides, if there is no autodetection, the

The autodetection will occur, reliably and without additional user 
information, from initramfs.

As Arjan said, we are moving this type of stuff out of the kernel.

	Jeff


