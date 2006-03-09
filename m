Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWCIRy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCIRy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWCIRy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:54:59 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:2569 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751026AbWCIRy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:54:58 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2 of 20] ipath - core device driver
X-Message-Flag: Warning: May contain useful information
References: <75d0a170fc9b4f016f8b.1141922815@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 09:54:57 -0800
In-Reply-To: <75d0a170fc9b4f016f8b.1141922815@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:46:55 -0800")
Message-ID: <adazmjzjyfi.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 17:54:57.0605 (UTC) FILETIME=[9427FF50:01C643A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	/* setup the chip-specific functions, as early as possible. */
 > +	switch (ent->device) {
 > +	case PCI_DEVICE_ID_INFINIPATH_HT:
 > +		ipath_init_ht400_funcs(dd);
 > +		break;
 > +	case PCI_DEVICE_ID_INFINIPATH_PE800:
 > +		ipath_init_pe800_funcs(dd);
 > +		break;

What happens if ht400 or pe800 support is not built?  How does this link?

 - R.
