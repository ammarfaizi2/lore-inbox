Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSKMWbF>; Wed, 13 Nov 2002 17:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSKMWbF>; Wed, 13 Nov 2002 17:31:05 -0500
Received: from dp.samba.org ([66.70.73.150]:29588 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262646AbSKMWbE>;
	Wed, 13 Nov 2002 17:31:04 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.54336.577805.474920@argo.ozlabs.ibm.com>
Date: Thu, 14 Nov 2002 09:37:52 +1100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Steve Lord <lord@sgi.com>, Anders Gustafsson <andersg@0x63.nu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5-bk AT_GID clash 
In-Reply-To: <20021113071630.190EC2C077@lists.samba.org>
References: <1037122398.27014.43.camel@jen.americas.sgi.com>
	<20021113071630.190EC2C077@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:

> But IMHO the nameclash needs to be fixed *anyway*, not hacked around,
> or someone else will run over it one day.  AFAICT, changing
> fs/binfmt_elf.c and elf.h to AT_RGID is the simplest.  Both should be
> mildly chastised for using a prefix like AT_ publically.

The name (AT_GID) is mandated by the ABI specification IIRC.

Paul.
