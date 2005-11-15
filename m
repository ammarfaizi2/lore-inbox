Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVKOIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVKOIYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVKOIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:24:13 -0500
Received: from [218.25.172.144] ([218.25.172.144]:64778 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751378AbVKOIYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:24:12 -0500
Date: Tue, 15 Nov 2005 16:24:08 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Block Device <blockdevice@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A standard snapshot notification framework in Linux ?
Message-ID: <20051115082408.GA3249@localhost.localdomain>
References: <64c763540511142345g4ca0b184y28962dae494f22b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c763540511142345g4ca0b184y28962dae494f22b4@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:15:54PM +0530, Block Device wrote:
> Hi,
> 
>    does the linux kernel provide a mechanism whereby applications can
> register themselves
> to be notified when a snapshot is being taken of the volume they might
> be writing to.
> 
>    If there is no such framework then how do backup applications
> guarantee ( application level ) consistency. I have seen freeze_bdev

call sync and mount read-only, or go down to init 1.

	Coywolf

> and friends which work for file systems and how the device mapper uses
> them. But when it comes to application level consistency, a mechanism
> is required to give the application a chance to flush &  quiesce its
> writes so that the backup taken will be consistent for the application
> also. Windows has the VSS ( Volume Shadow Service ) which provides an
> elaborate framework for this. Is anyone working on something similar
> for Linux and if not why is it not such a worthwhile idea ?
> 
> Regards
> BD
