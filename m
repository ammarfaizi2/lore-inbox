Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUE3SEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUE3SEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUE3SEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 14:04:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22435 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264304AbUE3SEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 14:04:15 -0400
Message-ID: <40BA2213.1090209@pobox.com>
Date: Sun, 30 May 2004 14:04:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andries Brouwer <aebr@win.tue.nl>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: 2.6.x partition breakage and dual booting
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So it seems that the 2.6.x geometry code breaks dual booting, since 
Windows wants "sane" CHS values.  See the thread on slashdot, or 
http://www.redhat.com/archives/fedora-devel-list/2004-May/msg00908.html

Although Fedora Core is current taking grief for this, it's really a 
2.6.x kernel problem AFAICT.

Has anybody taken the time to hunt down the csets that cause this 
massive partition table breakage?  If so, it will save me some time 
tracking this down.

	Jeff



