Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWAQMxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWAQMxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAQMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:53:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37802 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932468AbWAQMxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:53:33 -0500
Message-ID: <43CCE8C6.4010103@pobox.com>
Date: Tue, 17 Jan 2006 07:53:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, jason.d.gaston@intel.com
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] ata_piix: add Intel ICH8 device IDs
References: <200601170526.k0H5QpuM026968@shell0.pdx.osdl.net>
In-Reply-To: <200601170526.k0H5QpuM026968@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  akpm@osdl.org wrote: > From: Jason Gaston
	<jason.d.gaston@intel.com> > > Add the Intel ICH8 DID's to the
	ata_piix.c and quirks.c file for IDE mode SATA > support. > >
	Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com> > Signed-off-by:
	Andrew Morton <akpm@osdl.org> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> From: Jason Gaston <jason.d.gaston@intel.com>
> 
> Add the Intel ICH8 DID's to the ata_piix.c and quirks.c file for IDE mode SATA
> support.
> 
> Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

NAK, adds a duplicate entry to the locally declared struct ata_port_info.

Otherwise, OK.

	Jeff



