Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRBNLcM>; Wed, 14 Feb 2001 06:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131917AbRBNLcC>; Wed, 14 Feb 2001 06:32:02 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1064 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131578AbRBNLbx>; Wed, 14 Feb 2001 06:31:53 -0500
Date: Wed, 14 Feb 2001 05:31:47 -0600 (CST)
From: Philipp Rumpf <prumpf@mandrakesoft.mandrakesoft.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <20010214111700.X9459@redhat.com>
Message-ID: <Pine.LNX.3.96.1010214052651.12746B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Tim Waugh wrote:
> + * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
> + * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
> + * @device: PCI device id to match, or %PCI_ANY_ID to match all vendor ids

"match all device ids", surely ?

> + * @ss_device: PCI subsystem device id to match, or %PCI_ANY_ID to match all vendor ids

ditto.

(the pci_find_device documentation has "all vendor ids" as well)


