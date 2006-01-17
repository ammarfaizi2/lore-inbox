Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWAQCG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWAQCG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 21:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAQCG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 21:06:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751336AbWAQCG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 21:06:27 -0500
Date: Mon, 16 Jan 2006 18:05:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olaf Hering <olh@suse.de>
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in
 generic_shutdown_super
Message-Id: <20060116180529.45283133.akpm@osdl.org>
In-Reply-To: <20060116232957.GA26342@suse.de>
References: <20060116223431.GA24841@suse.de>
	<43CC2AF8.4050802@sw.ru>
	<20060116232957.GA26342@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> wrote:
>
>  On Tue, Jan 17, Kirill Korotaev wrote:
> 
> > Olaf, can you please check if my patch for busy inodes from -mm tree 
> > helps you?
> 
> I cant reprpoduce it at will, thats the thing. It likely happens with NFS
> mounts. agruen@suse.de did some work recently. But I remember even with
> these changes (for a 2.6.13), the busy inodes did not disappear.
> 
> Merging your patch into our cvs will give it more testing, I will do
> that tomorrow if noone disagrees.
> 

The patch is certainly safe and stable.  But it's so huge and complex and
ugly that I was hoping that a better fix would turn up.  The bug itself
takes quite some ingenuity to hit.
