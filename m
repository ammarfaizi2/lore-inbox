Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTKRIpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 03:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKRIpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 03:45:32 -0500
Received: from holomorphy.com ([199.26.172.102]:57510 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262119AbTKRIpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 03:45:31 -0500
Date: Tue, 18 Nov 2003 00:45:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: use ELF sections for get_wchan()
Message-ID: <20031118084529.GK22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031118074448.GD19856@holomorphy.com> <20031118084336.A28004@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118084336.A28004@flint.arm.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff -prauN linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in
> > --- linux-2.6.0-test9-bk22/arch/arm/boot/compressed/vmlinux.lds.in	2003-10-25 11:43:32.000000000 -0700
> > +++ wchan-2.6.0-test9-bk22-1/arch/arm/boot/compressed/vmlinux.lds.in	2003-11-17 23:14:03.000000000 -0800

On Tue, Nov 18, 2003 at 08:43:36AM +0000, Russell King wrote:
> You don't need to add to this file - this linker script takes the binary
> kernel image and puts the necessary decompressor magic around it.

Aha, thanks. I'll follow up with an amended patch (for both instances).


-- wli
