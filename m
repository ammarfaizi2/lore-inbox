Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTFPTWC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTFPTWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:22:01 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:6829 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264181AbTFPTWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:22:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Flameeyes <daps_mls@libero.it>
Date: Mon, 16 Jun 2003 21:35:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.71, fbconsole: No boot logo?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <49AA33D2A8D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jun 03 at 20:53, Flameeyes wrote:
> On Mon, 2003-06-16 at 20:39, ismail (cartman) donmez wrote:
> > Try  Graphics support  --->Logo configuration  --->[*] Bootup logo
> You can't activate the 224 colors logo without Bootup Logo active.
> I have the same problem with these lines in .config
> 
> CONFIG_LOGO=y
> CONFIG_LOGO_LINUX_MONO=y
> CONFIG_LOGO_LINUX_VGA16=y
> CONFIG_LOGO_LINUX_CLUT224=y

It is probably some uninitialized value or something like that.

At work I have no logo, while at home I have logo (both 2.5.71 from
yesterday), both with matroxfb... Only significant difference I know
is that at home I have UP kernel, while at work I have SMP. But it should 
not matter, yes?
                                        Petr Vandrovec

