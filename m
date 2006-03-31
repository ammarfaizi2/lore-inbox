Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWCaOAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWCaOAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCaOAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:00:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:5305 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751304AbWCaOAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:00:51 -0500
Message-ID: <442D3608.8090906@garzik.org>
Date: Fri, 31 Mar 2006 09:00:40 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] splice exports
References: <20060331040613.GA23511@havoc.gtf.org> <1143802879.3053.3.camel@laptopd505.fenrus.org> <20060331110233.GM14022@suse.de>
In-Reply-To: <20060331110233.GM14022@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Mar 31 2006, Arjan van de Ven wrote:
>> On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
>>> Woe be unto he who builds their filesystems as modules.
>>
>> since splice support is highly linux specific and new.. shouldn't these
>> be _GPL exports?
> 
> Yes they should, I'll add that to the current splice tree.

Why?  We don't usually restrict filesystems in such ways...  I would 
rather a binary-only module reference generic_file_splice_read() than 
create its own.

	Jeff



