Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUECLtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUECLtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUECLtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 07:49:03 -0400
Received: from users.linvision.com ([62.58.92.114]:61861 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262730AbUECLtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 07:49:00 -0400
Date: Mon, 3 May 2004 13:48:59 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails
Message-ID: <20040503114859.GC31513@harddisk-recovery.com>
References: <20040503105041.GA12023@Loki> <20040503113500.GB31513@harddisk-recovery.com> <20040503114316.GA22732@Loki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503114316.GA22732@Loki>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:43:16PM +0200, Libor Vanek wrote:
> > (BTW, if you need to copy files from kernel, it's usually a sign of bad
> > design)
> 
> It's not bad design - what I'm doing is writing snapshots for VFS as
> my diploma thesis. And I need to create copy of file before it's
> changed (copy-on-write). There is no other way how to do it in
> kernel-space (and user-space solutions like using LUFS are really
> slow)

Have a look at the cowlinks (copy-on-write links) thread from last
month, it might do the trick.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
