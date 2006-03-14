Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWCNOIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWCNOIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWCNOIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:08:37 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:65035 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751151AbWCNOIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:08:36 -0500
Date: Tue, 14 Mar 2006 15:08:28 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
Message-ID: <20060314140828.GA87175@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
	bluez-devel@lists.sf.net
References: <20060314111248.GA75477@dspnet.fr.eu.org> <1142344144.4448.3.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142344144.4448.3.camel@aeonflux.holtmann.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 02:49:03PM +0100, Marcel Holtmann wrote:
> your patch might break devices where this value is chosen on purpose

Please do tell me how one is supposed to do sco communications when
this value is chosen on purpose and I'll be happy to implement that.
I have found no clue about that in the bluetooth specs.

Meanwhile, I'll implement it with a quirk, and I can guarantee that
you're not going to like the result.  I have a list of 104 (iirc)
device ids that may need it, and given that hardware is supposed to
work they will have to be added until proven otherwise.

And it won't fix the uart versions either.

  OG.

