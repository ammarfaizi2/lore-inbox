Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbUC2VrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUC2VrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:47:24 -0500
Received: from localhost.nl ([62.250.6.43]:58888 "HELO maiden.localhost.nl")
	by vger.kernel.org with SMTP id S263148AbUC2VrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:47:21 -0500
Date: Mon, 29 Mar 2004 23:47:19 +0200
From: Marco Baan <marco@freebsd.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: failure to mount root fs
Message-ID: <20040329214719.GA68085@maiden.localhost.nl>
References: <26889266.1080559781017.JavaMail.www@wwinf3002> <1080561608.3570.2.camel@laptop.fenrus.com> <Pine.LNX.4.58.0403291537310.24736@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403291537310.24736@student.dei.uc.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 29 Mar 2004, Arjan van de Ven wrote:
> 
> It doesn't solve the problem, I have the same issue... And seeing kerneltrap
> forums, we're not the only ones.
> I fixed that problem by changing .config (it seems that oldconfig messed it) to
> show:
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> 
> Now I don't get the
> VFS: Unable to mount root fs on unknown-block(0,0)
> 
> but when booting, it shows:
> VFS: Mounted root (ext3 filesystem) readonly.
> 

I tried your config and the options. I dont get the readonly error though. Just the same error as before.

-- 
Marco Baan

On a paper submitted by a physicist colleague:

"This isn't right.  This isn't even wrong."
		-- Wolfgang Pauli
