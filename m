Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTFKT4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTFKT4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:56:33 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:15039 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262610AbTFKT4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:56:32 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "jds" <jds@soltis.cc>
Date: Wed, 11 Jun 2003 22:09:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Problem compile module vmnet VMWARE 4.0 in 2.4.70-mm8
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <423323B0465@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 03 at 13:30, jds wrote:

> bridge.c: In function `VNetBridgeReceiveFromVNet':
> bridge.c:368: structure has no member named `wmem_alloc'
> bridge.c: In function `VNetBridgeUp':
> bridge.c:618: structure has no member named `protinfo'
> bridge.c: In function `VNetBridgeReceiveFromDev':
> bridge.c:817: structure has no member named `protinfo'
> make: *** [bridge.o] Error 1
> make: Leaving directory `/tmp/vmware-config0/vmnet-only'
> Unable to build the vmnet module.

Add sk_ prefix to these members.
                                                    Petr
                                                    

