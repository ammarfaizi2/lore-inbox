Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUCQRJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUCQRJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:09:26 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:33421 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261532AbUCQRJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:09:25 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mark Watts <m.watts@eris.qinetiq.com>
Date: Wed, 17 Mar 2004 18:08:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware on linux 2.6.4
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <F395434A53@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 04 at 16:43, Mark Watts wrote:
> >
> > Update does not handle GSX 3.0 yet, so if you are using GSX 3.0, you
> > should stick with officially supported host kernels (if you bought
> > GSX, you probably want to have support, and so you should use only
> > supported hosts anyway).
> 
> We're actually toying with getting a copy of GSX - does it support 2.6 at all?

Same way WS4.5.1. It should work, but it was not specifically tested,
and I did not add gsx3 emulation layer into vmware-any-any-updates yet.

If you'll use kernel 2.6.x in the guest, you'll have some minor troubles
with building hgfs & vmxnet modules for the guest, but if you have
some exprience with kernel code it is trivial to fix them - two oneliners
in hgfs & two twoliners in vmxnet.
                                                    Petr Vandrovec
                                                    

