Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUEJHkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUEJHkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 03:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbUEJHkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 03:40:18 -0400
Received: from dns.texnet.it ([151.99.150.6]:7636 "EHLO dns.texnet.it")
	by vger.kernel.org with ESMTP id S264546AbUEJHkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 03:40:14 -0400
Date: Mon, 10 May 2004 09:40:11 +0200
From: Niccolo Rigacci <niccolo@rigacci.org>
To: linux-kernel@vger.kernel.org
Cc: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: 2Gb file size limit on 2.4.24, LVM and ext3?
Message-ID: <20040510074011.GA8690@paros.rigacci.org>
References: <20040506172152.GB17351@paros.rigacci.org> <409AA9EA.9020108@pointblue.com.pl> <20040507100142.GA30872@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507100142.GA30872@harddisk-recovery.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 12:01:42PM +0200, Erik Mouw wrote:
> No, glibc-2.2.5-11.5 will also do large files. Just be sure that you
> open() the file with O_LARGEFILE.


I definitively think that cp uses O_LARGEFILE. Infact if I strace
the command I can see:

   open("argo_full.tar.gz", O_RDONLY|O_LARGEFILE) = 3

but the problem now is that with strace the command works OK!
What the hell that stracing works and without strace it does not
work?

-- 
Niccolo Rigacci
Firenze - Italy

War against Iraq? Not in my name!
