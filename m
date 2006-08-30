Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWH3Wya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWH3Wya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWH3Wya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:54:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34739 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751598AbWH3Wy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:54:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44F6161B.40508@s5r6.in-berlin.de>
Date: Thu, 31 Aug 2006 00:50:03 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer
 [try #2]
References: <20060825142753.GK10659@infradead.org> <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de>
In-Reply-To: <20060830214356.GO18276@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> USB_STORAGE switched from a depending on SCSI to select'ing SCSI three 
> years ago, and ATA in 2.6.19 will also select SCSI for a good reason:
> 
> When doing anything kconfig related, you must always remember that the 
> vast majority of kconfig users are not kernel hackers.

I agree with that.
But multi-level dependencies are a show-stopper at the moment.
-- 
Stefan Richter
-=====-=-==- =--- =====
http://arcgraph.de/sr/
