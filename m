Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbTKTLf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 06:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTKTLf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 06:35:59 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:15558 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261746AbTKTLf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 06:35:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Date: Thu, 20 Nov 2003 12:35:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Cc: linux-kernel@vger.kernel.org, kerin@recruit2recruit.net
X-mailer: Pegasus Mail v3.50
Message-ID: <1014E066AA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 03 at 12:51, Voicu Liviu wrote:
> >
> >It has nothing to do with that, no. It is specific to 2.6.0-test9-mm4.
> >
> Ah, sorry, I got comfussed!
> Any way to get vmware working with  2.6.0-test9 or with 2.6.0-test9-bk24?

Just hit poweron button? Maybe you can download & install
ftp://platan.vc.cvut.cz/pub/vmware/vmware-any-any-update45.tar.gz before,
but there is no need for it unless you are using prebuilt RedHat's
kernels which are built with -mregparm=3... (and update45 does not
contain Christopher's patch for -mm4 yet).

BTW, anybody knows how to explain to gcc that inline assembly uses
push & pop, and so $esp relative addressing is not going to work very
well?
                                                        Thanks,
                                                            Petr Vandrovec
                                                            

