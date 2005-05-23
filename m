Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVEWSdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVEWSdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVEWSdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:33:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35785 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261911AbVEWSdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:33:04 -0400
Message-ID: <429221D8.90201@pobox.com>
Date: Mon, 23 May 2005 14:32:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan G <g-i-v@rambler.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA not works in Linux 2.6.12, but in Windows works fine.
References: <web-135595327@mail5.rambler.ru>
In-Reply-To: <web-135595327@mail5.rambler.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan G wrote:
> Problem descrition:
> 
> DMA not works in Linux 2.6.12, but in Windows works fine.
> 
> DMA not works with HDD and CD drives connected by 80-conductor
> cable to secondary IDE port (ide1).

This is expected behavior.

This is a limitation of "combined mode".  Turn off combined mode 
(sometimes called 'legacy' mode) in your BIOS, if your BIOS lets you.

	Jeff



