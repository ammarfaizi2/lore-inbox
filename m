Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263242AbVCDXwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbVCDXwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbVCDXui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:50:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:7341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263312AbVCDWs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:48:58 -0500
Date: Fri, 4 Mar 2005 14:48:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: rpurdie@rpsys.net, davej@redhat.com, torvalds@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304144808.75357ba3.akpm@osdl.org>
In-Reply-To: <20050304222719.B16178@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050304105247.B3932@flint.arm.linux.org.uk>
	<20050304032632.0a729d11.akpm@osdl.org>
	<20050304113626.E3932@flint.arm.linux.org.uk>
	<01ef01c520b7$94bebf80$0f01a8c0@max>
	<20050304132535.A9133@flint.arm.linux.org.uk>
	<039001c520e0$4ea3fbe0$0f01a8c0@max>
	<20050304142219.1e7ecfee.akpm@osdl.org>
	<20050304222719.B16178@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Fri, Mar 04, 2005 at 02:22:19PM -0800, Andrew Morton wrote:
> > That's now eight architectures I'll compile-test mm kernels on.
> 
> Cool, but please check whether this produces an error:
> 
> echo "mov r0, #foo" | arm-linux-as -o /dev/null -
> 
> you should get:
> {standard input}: Assembler messages:
> {standard input}:1: Error: undefined symbol foo used as an immediate value

I did get that.
