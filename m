Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUKGHzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUKGHzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKGHzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:55:32 -0500
Received: from main.gmane.org ([80.91.229.2]:44748 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261556AbUKGHz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:55:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Missing SCSI command in the allowed list?
Date: Sun, 07 Nov 2004 12:56:25 +0500
Message-ID: <cmkkd8$dm8$1@sea.gmane.org>
References: <cmikie$vif$1@sea.gmane.org> <200411061624.57918.dsd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:

> Hi,
> 
> On Saturday 06 November 2004 13:47, Alexander E. Patrakov wrote:
>> While cloning an audio CD using cdrdao 1.1.9 with vanilla linux-2.6.9 as
>> a user, I see the following "errors":
>>
>> ERROR: Read buffer capacity failed.
> 
> I submitted a patch for this a few days ago. It has been merged into
> Linus's tree.

Yes, I see the patch, thanks:

http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-axboe%40suse.de[torvalds]
ChangeSet|20041104154725|45958.txt

But the question remains: what should the users of not 100% MMC-compatible
CR-RW drives (i.e. those which have a separate cdrado or cdrecord driver,
not generic-mmc/generic-mmc-raw) do? Is the support for writing as non-root
on such drives just dropped without any plans to "fix" it?

-- 
Alexander E. Patrakov

