Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270226AbRHMOaM>; Mon, 13 Aug 2001 10:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270225AbRHMOaC>; Mon, 13 Aug 2001 10:30:02 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:17419 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S270224AbRHMO3o>;
	Mon, 13 Aug 2001 10:29:44 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4 
In-Reply-To: Your message of "Mon, 13 Aug 2001 14:05:05 +0200."
             <20010813120505.97748.qmail@web11808.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Aug 2001 00:29:50 +1000
Message-ID: <15667.997712990@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001 14:05:05 +0200 (CEST), 
Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:
> A good solution would be to have the kernel being two (or three) GZIP
> files concatenated, the first would be the real-mode code to setup
> the structure only, the second would be the protected-mode code of the
> kernel (and the third the initrd). The first part would be a position
> independant function getting some parameters (address/max size of the
> structure to fill in) and returning information like microprocessor
> minimum requirement, video mode supported (number of BPP, or text only),
> address the kernel has been linked (to load a kernel at 16 Mb), ...

Before you go too far, there is already an standard for boot loading,
EFI (Extensible Firmware Interface).  Originally from Intel but it is
open.  http://developer.intel.com/technology/efi.  IA64 uses this and
nothing but this, it already loads kernels in ELF format.  There is no
point in inventing yet another boot interface, unless you cannot do
what you want in EFI.

