Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWBURQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWBURQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBURQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:16:53 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:8720 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932328AbWBURQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:16:52 -0500
Message-ID: <43FB4AF4.80003@phoenixsoftware.de>
Date: Tue, 21 Feb 2006 18:16:36 +0100
From: Tilman Schmidt <t.schmidt@phoenixsoftware.de>
Organization: Phoenix Software GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Hansjoerg Lipp <hjlipp@web.de>, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Tilman Schmidt <tilman@imap.cc>
Subject: how to handle multi-part patch dependencies (was: [PATCH 1/9] isdn4linux:
 Siemens Gigaset drivers - Kconfigs and Makefiles)
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de> <gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de> <20060215031959.GA5099@suse.de>
In-Reply-To: <20060215031959.GA5099@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.281 () AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

thank you for your comments. Just a few follow-up questions.

On 15.02.2006 04:19, Greg KH wrote:

> On Sat, Feb 11, 2006 at 03:52:27PM +0100, Hansjoerg Lipp wrote:
> 
>>From: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>
>>
>>This patch prepares the kernel build infrastructure for addition of the
>>Gigaset ISDN drivers. It creates a Makefile and Kconfig file for the
>>Gigaset driver and hooks them into those of the isdn4linux subsystem.
>>It also adds a MAINTAINERS entry for the driver.
>>
>>This patch depends on patches 2 to 9 of the present set, as without the
>>actual source files, activating the options added here will cause the
>>kernel build to fail.
> 
> 
> Care to redo that and add the Makefile change at the same time as the
> driver goes into the tree?  We don't want to break the buid for a
> specific patch.

Could you tell me how to do that? How do I achieve that all parts of a
patchset go into the tree at the same time?

Thanks
Tilman

