Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275092AbRJJIb1>; Wed, 10 Oct 2001 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275087AbRJJIbR>; Wed, 10 Oct 2001 04:31:17 -0400
Received: from t2.redhat.com ([199.183.24.243]:5366 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S275092AbRJJIbH>; Wed, 10 Oct 2001 04:31:07 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <32924.24.255.76.12.1002702247.squirrel@webmail.morcant.org> 
In-Reply-To: <32924.24.255.76.12.1002702247.squirrel@webmail.morcant.org>  <3869.1002702058@redhat.com> 
To: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 09:31:36 +0100
Message-ID: <4100.1002702696@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



sirmorcant@morcant.org said:
> fs/nls/nls_cp737.c:MODULE_LICENSE("BSD without advertising clause");

> Warning: loading /lib/modules/2.4.11/kernel/fs/nls/nls_cp737.o will taint the kernel: 
> non-GPL license - BSD without advertising clause

> # cat /proc/sys/kernel/tainted  1 

Yes, that's a bug. Either that text needs to be added to the list of 
acceptable licences, or changed to "Dual BSD/GPL".

The warning should probably read 'Incompatible licence' instead of 'non-GPL',
too.

--
dwmw2


