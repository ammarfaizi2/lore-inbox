Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWC0TuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWC0TuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWC0TuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:50:16 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15050 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751451AbWC0TuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:50:14 -0500
Subject: Re: skeleton ide driver?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mws <mws@twisted-brains.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200603271941.42273.mws@twisted-brains.org>
References: <200603271941.42273.mws@twisted-brains.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 20:57:46 +0100
Message-Id: <1143489466.4970.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-27 at 19:41 +0200, Mws wrote:
> hi, 
> 
> is there a kind of skeleton ide driver available? 
> couldn't find anything on the net.

There isn't but some of the real ones are passable guides to how to
write something that works, especially if it is PCI bus. I'd also look
at libata and the libata PATA patch if you are working towards the
future rather than just needing something that works with the current
IDE layer.

What sort of hardware do you need to write a driver for ?

