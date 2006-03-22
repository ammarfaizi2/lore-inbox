Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWCVCMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWCVCMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 21:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCVCMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 21:12:07 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:29628 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751878AbWCVCMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 21:12:05 -0500
Message-ID: <4420B273.9030405@garzik.org>
Date: Tue, 21 Mar 2006 21:12:03 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
In-Reply-To: <200603210000.36552.lkml@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> This patch addresses a number of weird behaviours observed
> for the sata_mv driver, by fixing an "off by one" bug in processing
> of the EDMA response queue.
> 
> Basically, sata_mv was looking in the wrong place for
> command results, and this produced a lot of unpredictable behaviour.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied


