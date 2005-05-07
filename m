Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbVEGN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbVEGN3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbVEGN30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:29:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:29059 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263119AbVEGN2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:28:11 -0400
Message-ID: <427CC24F.9010304@suse.de>
Date: Sat, 07 May 2005 15:27:43 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Shawn Starr <shawn.starr@rogers.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up
 on A7M266-D
References: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com> <427BE2CA.7030007@suse.de> <20050507082548.GA18700@infradead.org>
In-Reply-To: <20050507082548.GA18700@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, May 06, 2005 at 11:34:02PM +0200, Stefan Seyfried wrote:
>> Known, XFS was broken / breaking wrt suspend. Pavel fixed this with the
>> XFS guys IIRC and i think those patches were on lkml also, but am not
>> sure. => this should work soon.
> 
> Pavel's fix wasn't enough.

That's what i wanted to tell with "...with the XFS guys..." :-)

> The fix that has been verified to work is
> in 2.6.12-rc4.

Ok, i only knew there was something in the works.

> qla1280 doesn't handle suspend/resume indeed.

As almost all SCSI stuff, which is no surprise to me since suspend /
resume seem rather uncommon on servers where SCSI is mostly used today
;-) I was more baffled to find out that the brand new SATA drivers had
no suspend support.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out."
