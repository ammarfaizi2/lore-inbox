Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLVRm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTLVRm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:42:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:62155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264461AbTLVRm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:42:57 -0500
Date: Mon, 22 Dec 2003 09:41:10 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 incorrect memory sizing (without a full BIOS)..
Message-Id: <20031222094110.31d57be9.rddunlap@osdl.org>
In-Reply-To: <20031219083148.GF22443@holomorphy.com>
References: <Pine.LNX.4.58.0312190451210.9093@skynet>
	<20031219083148.GF22443@holomorphy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 00:31:48 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:

| On Fri, Dec 19, 2003 at 05:04:25AM +0000, Dave Airlie wrote:
| > 	I've got an internal development board based on the Intel 815
| > chipset and the Intel ACSFL mini-BIOS for embedded systems, and then using
| > grub 0.93 to boot Linux.
| > under 2.4 my memory is correctly sized at 256MB, but under 2.6 I'm only
| > seeing 64MB,
| [... e88/e820 snipped ...]
| > So is this 2.6 just being more fussy about the contents of the e820 that
| > my "BIOS" is supplying and falling back to the old style detection?
| 
| We've had one other report of something like this. I don't see any
| obvious reason why setup.S should be failing in 2.6; diff below. It
| could be some kind of binutils issue.
| 
| Could I get dmesg and .config from 2.4 and 2.5?

Did we ever get these message logs and config files?

--
~Randy
MOTD:  Always include version info.
