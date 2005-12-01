Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVLAHji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVLAHji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 02:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVLAHji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 02:39:38 -0500
Received: from mail.dvmed.net ([216.237.124.58]:30657 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750748AbVLAHjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 02:39:37 -0500
Message-ID: <438EA8B6.9050509@pobox.com>
Date: Thu, 01 Dec 2005 02:39:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RESEND] [PATCH] drivers/net/wireless/airo.c unsigned comparason
References: <43749512.8040002@staticwave.ca>
In-Reply-To: <43749512.8040002@staticwave.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Gabriel A. Devenyi wrote: > fid is declared as a u32
	(unsigned int), and then a few lines later, it > is checked for a value
	< 0, which is clearly useless. > In the two locations this function is
	used, in one it is *explicitly* > given a negative number, which would
	be ignored with the > current definition. > > Thanks to LinuxICC
	(http://linuxicc.sf.net). > > This patch applies to linus' git tree as
	of 03.11.2005 > > Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel A. Devenyi wrote:
> fid is declared as a u32 (unsigned int), and then a few lines later, it 
> is checked for a value < 0, which is clearly useless.
> In the two locations this function is used, in one it is *explicitly* 
> given a negative number, which would be ignored with the
> current definition.
> 
> Thanks to LinuxICC (http://linuxicc.sf.net).
> 
> This patch applies to linus' git tree as of 03.11.2005
> 
> Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>


[jgarzik@pretzel netdev-2.6]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
1 patch(es) to process.

Applying 'drivers/net/wireless/airo.c unsigned comparason'

fatal: corrupt patch at line 8
