Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWCVXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWCVXWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWCVXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:22:41 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:23448 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932431AbWCVXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:22:40 -0500
Message-ID: <4421DC39.2090204@garzik.org>
Date: Wed, 22 Mar 2006 18:22:33 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>, hpa@zytor.com
CC: Michael Neuling <mikey@neuling.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       klibc@zytor.com, Al Viro <viro@ftp.linux.org.uk>, miltonm@bga.com
Subject: Re: [PATCH] initramfs: CPIO unpacking fix
References: <20060216183745.50cc2bf6.mikey@neuling.org> <20060322061220.8414067A70@ozlabs.org> <4420F93C.1050705@garzik.org> <200603221723.29279.rob@landley.net>
In-Reply-To: <200603221723.29279.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> First initramfs.cpio.gz built into the kernel, second initramfs.cpio.gz 
> supplied as an external file via the initrd mechanism.  Both get extracted 
> into the same rootfs, and I believe external one will overwrite the internal 
> one if files conflict.

Based on this and HPA's response, I definitely stand corrected.

	Jeff


