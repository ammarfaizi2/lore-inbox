Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbTGWIMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbTGWIMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:12:21 -0400
Received: from netix1.demon.co.uk ([212.228.80.161]:2063 "EHLO netunix.com")
	by vger.kernel.org with ESMTP id S267978AbTGWIMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:12:19 -0400
Date: Wed, 23 Jul 2003 09:33:40 +0100 (BST)
From: "C.Newport" <crn@netunix.com>
To: "David S. Miller" <davem@redhat.com>
cc: Otto Solares <solca@guug.org>, <hch@infradead.org>, <zaitcev@redhat.com>,
       <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>,
       <debian-sparc@lists.debian.org>
Subject: Re: sparc scsi esp depends on pci & hangs on boot
In-Reply-To: <20030723002737.376d93ca.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0307230926170.26107-100000@hek.netunix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, David S. Miller wrote:

> If the architecture wants to support such situations,
> then the implementation needs to vector off to different
> operations based upon the actual bus type.
>
> Even though technically devices having SBUS and PCI variants could do
> this, none do currently, and also I do not use the generic device
> model in the SBUS layer, therefore I'm not going to add such multi-bus
> support to what Sparc uses for dma-mapping.h

Ouch - As I mentioned a few days ago, the Ex000 range can have a
mixture of SBUS and PCI. This configuration is becoming increasingly
common as these machines are upgraded to attach to SAN stuff and
other FCAL variants for which there is no SBUS card.

Please take a few moments to keep this, it works at the moment.


