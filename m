Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUE3R1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUE3R1D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUE3R1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:27:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264253AbUE3R0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:26:42 -0400
Message-ID: <40BA1946.3020509@pobox.com>
Date: Sun, 30 May 2004 13:26:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@ncc1701.cistron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.7-rc2
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org> <c9c42l$228$1@news.cistron.nl>
In-Reply-To: <c9c42l$228$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> Linus Torvalds  <torvalds@osdl.org> wrote:
> 
>>Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
>>============================================
> 
> 
> Ethernet stopped working (for me) going from 2.6.7-rc1-bk3 to 2.6.7-rc2.
> AMD64/asusK8V with onboard ethernet.
> Dhclient tried to find dhcp server but no response.
> Configuration by hand yielded same non-working situation.
> Packets where "transmitted" but none received.
> 2.6.7-rc1-bk3 worked like intended.


What net driver do you use?  Did you try booting with 'noapic' or 
'acpi=off' or 'pci=noacpi'?

Some more details a la REPORTING-BUGS file in the kernel source would be 
helpful.

	Jeff


