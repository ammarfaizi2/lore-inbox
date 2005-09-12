Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVILXwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVILXwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVILXwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:52:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:20189 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932367AbVILXwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:52:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43261488.5040309@s5r6.in-berlin.de>
Date: Tue, 13 Sep 2005 01:51:36 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Matthew Wilcox <matthew@wil.cx>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org> <20050912160805.GC32395@parisc-linux.org> <4325D1E8.9030302@adaptec.com> <20050912195521.GD32395@parisc-linux.org>
In-Reply-To: <20050912195521.GD32395@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.539) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Sep 12, 2005 at 03:07:20PM -0400, Luben Tuikov wrote:
>>No, my point is that SCSI Core "development" isn't following any
>>spec or document or any formally accepted spec.
> 
> That's right.  And it's actually a good thing.

Are you two discussing specs for scsi subsystem development process 
here, or are you discussing specs for scsi subsystem architecture?

In case of the latter: These are indispensable. The scope of the scsi 
subsystem is big enough to benefit from following the T10 specs, 
including their concepts, their layers. I am saying this as somebody who 
is trying to bring one small part of the subsystem forward, who will 
never be able to grasp what is going on throughout the whole subsystem 
nor to learn all about all SCSI layers. Thereby, every bigger or smaller 
layering violation, every common SCSI concept that I have trouble to 
match with Linux' scsi concepts will be a bigger or smaller setback for 
undertakings like mine. (Well, I'm stating the obvious, or so I hope.)
-- 
Stefan Richter
-=====-=-=-= =--= -==-=
http://arcgraph.de/sr/
