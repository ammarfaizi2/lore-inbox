Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVHVUiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVHVUiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVHVUiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:38:25 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:37393 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751109AbVHVUiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:38:23 -0400
Date: Mon, 22 Aug 2005 22:39:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: libata TODO: ioread/iowrite work (was Re: [PATCH libata:upstream] remove compiler warnings)
Message-ID: <20050822203905.GA17753@mars.ravnborg.org>
References: <20050822091129.GA15373@htj.dyndns.org> <430A2C91.4060803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430A2C91.4060803@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - install Linus's "sparse" source checker
> - run 'make C=1' in the kernel tree, and make sure libata and drivers 
> don't spew warnings
make C=2 will check all files. Handy so you do not need to do a make
clean.
make C=2 drivers/scsi/libata.ko to limit it to libata.

	Sam
