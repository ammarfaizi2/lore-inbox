Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTDWW4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbTDWW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:56:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32642
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264285AbTDWW4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:56:40 -0400
Subject: Re: [PATCH] 2.5.67-ac2 direct-IO for IDE taskfile ioctl (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030423153500.0d99b4d3.akpm@digeo.com>
References: <Pine.SOL.4.30.0304231933360.10502-100000@mion.elka.pw.edu.pl>
	 <20030423153500.0d99b4d3.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051135786.2064.98.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 23:09:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-23 at 23:35, Andrew Morton wrote:
> Dumb question: what does all this code actually do?
> 
> It appears to be implementing an IDE-specific ioctl() which performs bulk
> IO direct to/from userspace.  But that seems to be equivalent to O_DIRECT
> access to /dev/hda.
> 
> What is special about the IDE ioctl approach?

Think /dev/sg at the ATA level


