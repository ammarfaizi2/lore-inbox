Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTKQBMS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTKQBMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 20:12:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33591 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261262AbTKQBMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 20:12:17 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow modular BINFMT_ELF
References: <20031115232600.GF7919@fs.tum.de> <3FB6BB35.8090001@pobox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Nov 2003 18:09:11 -0700
In-Reply-To: <3FB6BB35.8090001@pobox.com>
Message-ID: <m1vfpjol6w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Adrian Bunk wrote:
> > modular BINFMT_ELF gives unresolved symbols in 2.4 .
> > modular BINFMT_ELF gives the following unresolved symbols in 2.6:
> 
> 
> Interesting.  this causes me to wonder if we should bother making BINFMT_ELF an
> 
> option at all...

We have platforms uClinux for which ELF is not the preferred format so we
should at least be able to compile it out.

Eric
