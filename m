Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVEPWQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVEPWQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVEPWOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:14:31 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:51394 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261954AbVEPWL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:11:29 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: maneesh@in.ibm.com
Subject: Re: kexec?
Date: Tue, 17 May 2005 00:11:43 +0200
User-Agent: KMail/1.7.2
Cc: Vivek Goyal <vgoyal@in.ibm.com>, coywolf@lovecn.org,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
References: <20050508202050.GB13789@charite.de> <200505111351.42266.petkov@uni-muenster.de> <20050512064119.GA3870@in.ibm.com>
In-Reply-To: <20050512064119.GA3870@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200505170011.44196.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>
> It will be nice if you could try kdump also on the similar lines.

HI,

After patching kexec-tools with the kdump patch here's what I did according to 
the test plan:

0. load kernel with crashkernel=64M@16M
1. kexec -p vmlinux --args-linux --append="root=/dev/hda1 init 1" (loads fine)
2. sysrq+c
the system issues here : SysRq: Trigger a crashdump and hangs so that even 
SysRq is dead.


Regards,
Boris.
