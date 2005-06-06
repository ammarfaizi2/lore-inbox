Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVFFXaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVFFXaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVFFXTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:19:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:30154 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261749AbVFFXIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:08:45 -0400
Message-ID: <42A4D771.7080400@pobox.com>
Date: Mon, 06 Jun 2005 19:08:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de>
In-Reply-To: <20050606225548.GA11184@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Why would it matter?  The driver shouldn't care if the interrupts come
> in via the standard interrupt way, or through MSI, right?  And if it

It matters.

Not only the differences DaveM mentioned, but also simply that you may 
assume your interrupt is not shared with anyone else.

	Jeff



