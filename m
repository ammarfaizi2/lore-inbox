Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTFKU3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTFKU2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:28:38 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:33413
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S264465AbTFKUYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:24:49 -0400
From: "jds" <jds@soltis.cc>
To: Andrew Morton <akpm@digeo.com>, "jds" <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compile module vmnet VMWARE 4.0 in 2.4.70-mm8
Date: Wed, 11 Jun 2003 14:09:10 -0600
Message-Id: <20030611200731.M1071@soltis.cc>
In-Reply-To: <20030611130850.358276ae.akpm@digeo.com>
References: <20030611192737.M39931@soltis.cc> <20030611130850.358276ae.akpm@digeo.com>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Andrew:

   Thanks.... :)

   Changes the bridge.c and compile good module vmnet

   Best Regards.

   Muchas Gracias

---------- Original Message -----------
From: Andrew Morton <akpm@digeo.com>
To: "jds" <jds@soltis.cc>
Sent: Wed, 11 Jun 2003 13:08:50 -0700
Subject: Re: Problem compile module vmnet VMWARE 4.0 in 2.4.70-mm8

> "jds" <jds@soltis.cc> wrote:
> >
> >     I have problems when compile module vmware 4.0 vmnet with kernel
2.5.70-mm8.
> > 
> > ...
> >  
> > make: Entering directory `/tmp/vmware-config0/vmnet-only'
> > bridge.c: In function `VNetBridgeReceiveFromVNet':
> > bridge.c:368: structure has no member named `wmem_alloc'
> > bridge.c: In function `VNetBridgeUp':
> > bridge.c:618: structure has no member named `protinfo'
> > bridge.c: In function `VNetBridgeReceiveFromDev':
> > bridge.c:817: structure has no member named `protinfo'
> > make: *** [bridge.o] Error 1
> > make: Leaving directory `/tmp/vmware-config0/vmnet-only'
> > Unable to build the vmnet module.
> 
> You'll need to replace all instances of "wmem_alloc" with "sk_wmem_alloc"
> and replace all instances of "protinfo" with "sk_protinfo".  And 
> similar if you get more compile errors.
> 
> Lots of socket members were renamed, by adding an "sk_" prefix.
------- End of Original Message -------

