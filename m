Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVAMKVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVAMKVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVAMKVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:21:50 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:53766 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261555AbVAMKVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:21:49 -0500
Message-ID: <41E64DAB.1010808@hist.no>
Date: Thu, 13 Jan 2005 11:30:03 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10 boots fine, but is killed by the X server when it
tries to initialize my PCI radeon 9200 SE.  This problem exists
in 2.6.9 too, but not in 2.6.8.1.  So I'm stuck with that version currently.

The problem seems to be access to the card bios, X uses
int10 bios calls to initialize the card.

Helge Hafting
