Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbRACWH3>; Wed, 3 Jan 2001 17:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131401AbRACWHL>; Wed, 3 Jan 2001 17:07:11 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:29427 "HELO
	the-babel-tower.nobis.phear.org") by vger.kernel.org with SMTP
	id <S129518AbRACWGx>; Wed, 3 Jan 2001 17:06:53 -0500
Date: Wed, 3 Jan 2001 23:12:03 +0100 (CET)
From: Nicolas Noble <Pixel@the-babel-tower.nobis.phear.org>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0101032307100.11696-100000@the-babel-tower.nobis.phear.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Dan Aloni wrote:

> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using printk.
> 

Hum,

Allow-me to give you this URL where you will be able to find a more
complete patch to do the very same thing. I don't tell you this will work
as you need but I think this is a good reason to abandon your project
since this patch really do the same (and adds others security features to
the kernel)

Here: http://www.openwall.com/linux/

Best regards.

  -- Nicolas Noble


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
