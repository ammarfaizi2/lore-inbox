Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbVCEAg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbVCEAg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbVCEAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:06:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2828 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263401AbVCDXEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:04:25 -0500
Date: Fri, 4 Mar 2005 23:04:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304230421.C16178@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk> <039001c520e0$4ea3fbe0$0f01a8c0@max> <20050304142219.1e7ecfee.akpm@osdl.org> <20050304222719.B16178@flint.arm.linux.org.uk> <20050304144808.75357ba3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050304144808.75357ba3.akpm@osdl.org>; from akpm@osdl.org on Fri, Mar 04, 2005 at 02:48:08PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:48:08PM -0800, Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> > On Fri, Mar 04, 2005 at 02:22:19PM -0800, Andrew Morton wrote:
> > > That's now eight architectures I'll compile-test mm kernels on.
> > 
> > Cool, but please check whether this produces an error:
> > 
> > echo "mov r0, #foo" | arm-linux-as -o /dev/null -
> > 
> > you should get:
> > {standard input}: Assembler messages:
> > {standard input}:1: Error: undefined symbol foo used as an immediate value
> 
> I did get that.

Great - this will help ensure that any breakage due to that binutils
problem should get caught relatively quickly no matter how it gets in
to either your or Linus' kernel.  This is a definite plus.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
