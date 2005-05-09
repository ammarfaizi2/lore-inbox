Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEIMqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEIMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVEIMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:46:25 -0400
Received: from mail.suse.de ([195.135.220.2]:19638 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261349AbVEIMqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:46:16 -0400
Message-ID: <427F230E.4040906@suse.de>
Date: Mon, 09 May 2005 10:45:02 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Shawn Starr <shawn.starr@rogers.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up
 on A7M266-D
References: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com> <20050507082548.GA18700@infradead.org> <427CC24F.9010304@suse.de> <200505090245.05662.spstarr@sh0n.net>
In-Reply-To: <200505090245.05662.spstarr@sh0n.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> Well, it makes sense,

I tend to disagree

> normally you won't find SCSI on

low-end-

> desktops so why bother 
> with suspend.

One example: developers often have SCSI systems. They cannot help fixing
their (audio|video|network card) drivers because they cannot test it.

> I don't know if the cards can do it or not, since they need 
> their firmware loaded at driver init.

Lots of drivers do this without much problems. Wireless cards are a
prime example.

> The firmware would need to be modified 
> to support such state?

I don't believe so.
-- 
seife
                                 Never trust a computer you can't lift.

