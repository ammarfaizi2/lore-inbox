Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTIHN15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTIHNZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:25:46 -0400
Received: from main.gmane.org ([80.91.224.249]:33708 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262328AbTIHNZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:25:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [blockdevices/NBD] huge read/write-operations are splitted by
 the kernel
Date: Mon, 08 Sep 2003 15:26:01 +0200
Message-ID: <bji001$sop$1@sea.gmane.org>
References: <bjgh6a$82o$1@sea.gmane.org> <20030908085802.GH840@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030818
X-Accept-Language: en-us, en
In-Reply-To: <20030908085802.GH840@suse.de>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You'll probably find that if you bump the max_sectors count if your
> drive to 256 from 255 (that is the default if you haven't set it), then
> you'll see 128kb chunks all the time.
> 
> See max_sectors[] array.

To make it clear:
the kernel will never read or write more sectors at once than specified 
in the max_sectors array (where every device has its own value), right?


