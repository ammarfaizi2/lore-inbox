Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTDUDm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 23:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263548AbTDUDm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 23:42:56 -0400
Received: from terminus.zytor.com ([63.209.29.3]:28878 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263516AbTDUDmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 23:42:55 -0400
Message-ID: <3EA36B88.3070208@zytor.com>
Date: Sun, 20 Apr 2003 20:54:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] more kdev_t-ectomy
References: <UTC200304210132.h3L1WY215924.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304210132.h3L1WY215924.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> That is something private to the NFS code.
> The standard leaves the structure undefined, so whatever we do is OK.
> It seems reasonable to allow some mount option to specify
> whether the other side is Solaris-like, with 8:8 / 14:18,
> or FreeBSD-like, with 8:24, or Linux like ...
> 
> Filesystems that are offered more dev_t bits than they can handle
> must just return -EOVERFLOW.
> 

Yes.  It seems useful to centralize this, though.

	-hpa


