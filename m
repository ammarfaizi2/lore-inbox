Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292770AbSCDTNA>; Mon, 4 Mar 2002 14:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292779AbSCDTMu>; Mon, 4 Mar 2002 14:12:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12556 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292770AbSCDTMf>;
	Mon, 4 Mar 2002 14:12:35 -0500
Message-ID: <3C83C737.397989BE@mandrakesoft.com>
Date: Mon, 04 Mar 2002 14:12:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Dillow <dillowd@y12.doe.gov>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes (round 3)
In-Reply-To: <Pine.LNX.4.33.0203041023580.11065-100000@janetreno.austin.ibm.com>
		 <3C83A925.F93BF448@mandrakesoft.com> <3C83AE6B.9B5DE85F@y12.doe.gov>
		 <3C83B2E7.B5EB0FB5@mandrakesoft.com> <3C83C0B8.659F1AE@y12.doe.gov> <3C83C258.FCF57746@mandrakesoft.com> <3C83C4B6.B7A95B5A@y12.doe.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Dillow wrote:
> Jeff Garzik wrote:
> > pci_enable_device doesn't touch PCI_COMMAND_INVALIDATE either, on most
> > platforms (particularly ia32, i.e. the popular one :))

> This seems to be a common thing to set; shouldn't we have a helper for
> it as well, or have pci_enable_device() do it?

Quoting my message to you from a couple hours ago:
> I need to create a pci_set_mwi() helper function.

	Jeff



-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
