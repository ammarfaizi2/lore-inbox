Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWFTQQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWFTQQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFTQQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:16:24 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:36474 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751381AbWFTQQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:16:23 -0400
Date: Tue, 20 Jun 2006 18:16:21 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Walkinair <walktodeath@163.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get kernel source release from git tree?
Message-ID: <20060620161620.GA4487@harddisk-recovery.com>
References: <4497830B.5010402@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4497830B.5010402@163.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 01:09:31PM +0800, Walkinair wrote:
> Hi, this may be a stupid question, sorry for this.
> 
> I have kenel 2.6 git tree in my local box, usually through the following 
> steps I get source release,
> 1. copy git repository to a new directory.
> 2. rm .git directory.
> 3. make config; make; make modules_install; make install
> 
> I there any convinient git command or other ways to get kernel release 
> from git repository?

What about this?

  git tar-tree v2.6.17 linux-2.6.17 | ( cd .. ; tar xpf - )


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
