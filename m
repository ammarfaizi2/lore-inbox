Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTD3XvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTD3XvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:51:17 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:7151 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262572AbTD3XvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:51:16 -0400
Message-ID: <3EB06455.BF253092@eyal.emu.id.au>
Date: Thu, 01 May 2003 10:03:33 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-rc1-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mauricio Oliveira Carneiro <carneiro@tecgraf.puc-rio.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 
References: <oprogo4fzred667r@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Oliveira Carneiro wrote:

> But I can't see it mounted anywhere in my system, nor can I mount it by
> hand since I don't know the device filename (/dev/?) .

The device is the next available scsi, e.g.:
	mount /dev/sda1 /mnt

My /etc/fstab has this:

# USB camera as mass-storage, Nikon Coolpix 2000
#
none               /proc/bus/usb        usbdevfs  noauto          0 0
/dev/sda1          /nikon               msdos     noauto          0 0

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
