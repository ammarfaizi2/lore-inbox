Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271155AbTGWIQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbTGWIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:16:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64911 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271141AbTGWIPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:15:48 -0400
Date: Wed, 23 Jul 2003 01:28:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: "C.Newport" <crn@netunix.com>
Cc: solca@guug.org, hch@infradead.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030723012824.5d8dec9b.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0307230926170.26107-100000@hek.netunix.com>
References: <20030723002737.376d93ca.davem@redhat.com>
	<Pine.LNX.4.33.0307230926170.26107-100000@hek.netunix.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 09:33:40 +0100 (BST)
"C.Newport" <crn@netunix.com> wrote:

> Ouch - As I mentioned a few days ago, the Ex000 range can have a
> mixture of SBUS and PCI.

So what?

> This configuration is becoming increasingly
> common as these machines are upgraded to attach to SAN stuff and
> other FCAL variants for which there is no SBUS card.

Nothing I have said prevents these systems from fully
working.

Because I won't move SBUS over to generic struct device,
none of the SBUS device drivers will change either, therefore
everything works as it does today.

What's the problem?
