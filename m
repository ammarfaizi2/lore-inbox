Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUGGQHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUGGQHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 12:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUGGQHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 12:07:44 -0400
Received: from users.linvision.com ([62.58.92.114]:27792 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S265199AbUGGQHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 12:07:43 -0400
Date: Wed, 7 Jul 2004 18:07:42 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Brad Tilley <bradtilley@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Directory where modules are loacted in 2.6.7 build
Message-ID: <20040707160742.GH8347@harddisk-recovery.com>
References: <922iggP8L3328S17.1089215951@uwdvg017.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922iggP8L3328S17.1089215951@uwdvg017.cms.usa.net>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 11:59:11AM -0400, Brad Tilley wrote:
> When a normal user on a x86 PC builds a 2.6.x kernel in his home directory by
> issuing the 'make' command where are the modules placed? 

Just in the build tree.

You need to be root to install the modules in /lib/modules using "make
modules_install", but everything else can be done as a normal user. If
you want to have them installed somewhere else, you don't need to be
root, btw, "make INSTALL_MOD_PATH=/tmp modules_install" will install
the modules in /tmp/lib/modules .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
