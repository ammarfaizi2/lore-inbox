Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUBXPVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbUBXPVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:21:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262259AbUBXPVi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:21:38 -0500
Message-ID: <403B6BF3.8070301@pobox.com>
Date: Tue, 24 Feb 2004 10:21:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver
References: <200402241110.07526.andrew@walrond.org>
In-Reply-To: <200402241110.07526.andrew@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> I've got a 378 s150 tx chipset with their fasttrak raid bios. How should I 
> configure the drives to use with the 2.6.3 kernel promise SATA driver? Can I 
> configure them as a raid array?

The 2.6.3 sata_promise driver ignores any RAID configuration you set up, 
and directly talks to the drives.

	Jeff



