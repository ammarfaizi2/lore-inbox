Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264229AbTCXOKC>; Mon, 24 Mar 2003 09:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264230AbTCXOKC>; Mon, 24 Mar 2003 09:10:02 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:5269 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264229AbTCXOKB>;
	Mon, 24 Mar 2003 09:10:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Mon, 24 Mar 2003 15:20:42 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Fwd: RE: kernel compile on phoebe 3]
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <5874B87FB9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 03 at 15:09, Felipe Alfaro Solana wrote:
> 
> For some reason I don't get /proc/ksyms file with 2.5 kernels I compile, and
> that causes rc.sysinit to set /proc/sys/kernel/modprobe to /bin/true. What
> option enables /proc/ksyms creation?

None. /proc/ksyms is gone. Fix initscript to not touch 
/proc/sys/kernel/modprobe, I see no reason why it should touch it unless
you want to kill modprobe functionality - and then it should depend on
some configuration setting and not on existence of /proc/ksyms.
                                                          Petr Vandrovec
                                                          

