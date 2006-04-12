Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDLFfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDLFfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDLFfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:35:01 -0400
Received: from [4.79.56.4] ([4.79.56.4]:23979 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1750807AbWDLFfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:35:00 -0400
Subject: Re: add new code section for kernel code
From: Arjan van de Ven <arjan@infradead.org>
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Dimitry Andric <dimitry@andric.com>, Paolo Ornati <ornati@fastwebnet.it>,
       linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
In-Reply-To: <c70ff3ad0604110749s26e92345s60729434162c7212@mail.gmail.com>
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
	 <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
	 <1144422864.3117.0.camel@laptopd505.fenrus.org>
	 <20060407154349.GB31458@flint.arm.linux.org.uk>
	 <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
	 <20060409203046.GA24461@flint.arm.linux.org.uk>
	 <443A2196.5090306@andric.com>
	 <c70ff3ad0604110749s26e92345s60729434162c7212@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 07:34:17 +0200
Message-Id: <1144820057.3089.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 17:49 +0300, saeed bishara wrote:
> inorder to reduce image size of the kenrel I added the --gc-secions
>  flag to the LDFALGS_vmlinux, the image size reduced by 120KB (out of
> 1.8M), but the kernel failed to boot ( after the uncompression stage).
> any idea?
> I see that the fvr arch aleady using those flags.

there are some known binutils "issues" (or better "interactions") that
make this not yet practical.


