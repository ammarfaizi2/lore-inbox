Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTIHMuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbTIHMuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:50:15 -0400
Received: from main.gmane.org ([80.91.224.249]:28582 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262301AbTIHMuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:50:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [blockdevices/NBD] huge read/write-operations are splitted by
 the kernel
Date: Mon, 08 Sep 2003 14:42:07 +0200
Message-ID: <bjhtmm$crf$1@sea.gmane.org>
References: <bjgh6a$82o$1@sea.gmane.org> <20030908085802.GH840@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
In-Reply-To: <20030908085802.GH840@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You'll probably find that if you bump the max_sectors count if your
> drive to 256 from 255 (that is the default if you haven't set it), then
> you'll see 128kb chunks all the time.

Why is 255 the default. It seems to be an inefficient value. Perhaps the 
NBD itself should set it to 256.

> See max_sectors[] array.

Well, i found the declaration, but i can't imagine how to set the values 
in it.


