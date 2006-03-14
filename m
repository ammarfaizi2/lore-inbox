Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWCNWWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWCNWWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWCNWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:22:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13970 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932451AbWCNWWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:22:10 -0500
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <20060314140828.GA87175@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
	 <1142344144.4448.3.camel@aeonflux.holtmann.net>
	 <20060314140828.GA87175@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Mar 2006 22:27:56 +0000
Message-Id: <1142375276.3623.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-14 at 15:08 +0100, Olivier Galibert wrote:
> Meanwhile, I'll implement it with a quirk, and I can guarantee that
> you're not going to like the result.  I have a list of 104 (iirc)
> device ids that may need it, and given that hardware is supposed to
> work they will have to be added until proven otherwise.

Just add a wildcard quirk so your fixup is called for every single
device and then does the check. Keeps the fix out of the core and
clearly documented while keeping the list short.

