Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWH3Iri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWH3Iri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWH3Iri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:47:38 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:34959 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1750708AbWH3Irh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:47:37 -0400
Message-ID: <44F54FB0.7080203@s5r6.in-berlin.de>
Date: Wed, 30 Aug 2006 10:43:28 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] BLOCK: Make USB storage depend on SCSI rather than
 selecting it [try #6]
References: <44F4ADD7.4020604@s5r6.in-berlin.de>  <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com> <20060829180631.32596.69574.stgit@warthog.cambridge.redhat.com> <18771.1156926354@warthog.cambridge.redhat.com>
In-Reply-To: <18771.1156926354@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> What about this?
>> 
>>  	depends on USB
>> +	select BLOCK
>>  	select SCSI
> 
> That means you can't disable BLOCK either unless you can figure out that you
> need to turn off USB_STORAGE.  The config client won't tell you, you have to
> go trawling the Kconfig files.

Not true. Both xconfig and menuconfig tell you about _both_ "depends on"
and "select" dependencies.
-- 
Stefan Richter
-=====-=-==- =--- ====-
http://arcgraph.de/sr/
