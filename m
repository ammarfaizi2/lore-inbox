Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265580AbUE0Woq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUE0Woq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 18:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUE0Woq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 18:44:46 -0400
Received: from lug.demon.co.uk ([80.177.165.112]:14157 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S265580AbUE0Wop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 18:44:45 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Date: Thu, 27 May 2004 23:44:55 +0100
User-Agent: KMail/1.6
References: <200405271736.08288.dj@david-web.co.uk> <200405271925.24650.dj@david-web.co.uk> <1085695702.10106.65.camel@buffy>
In-Reply-To: <1085695702.10106.65.camel@buffy>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405272344.55003.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 May 2004 23:08, David Aubin wrote:
> Hi Dave,
>
>   You do not have devfs enabled.  So root=/dev/hda3
> should not work.  Please enable in kernel and retry.
>
> # CONFIG_DEVFS_FS is not set
>

But surely enabling devfs will stop /dev/hda3 working completely. Then 
wouldn't the path be something like /dev/ide/disk0/part1/blah/blah/blah.

I'm not using devfs with 2.4 and it works fine.

Thanks,
David.

-- 
David Johnson
http://www.david-web.co.uk/
