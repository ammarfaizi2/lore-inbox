Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUFAQ0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUFAQ0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUFAQ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:26:11 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:15077 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265127AbUFAQZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:25:12 -0400
Date: Tue, 1 Jun 2004 17:24:07 +0100
From: Dave Jones <davej@redhat.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel-agp: skip non-AGP devices
Message-ID: <20040601162407.GB1265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
References: <20040601160457.GA11437@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601160457.GA11437@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 11:04:57AM -0500, Matt Domsch wrote:

 > On our PowerEdge 2600 system, which has an Intel E7501 Memroy
 > Controller Hub, the intel-agp probe code is reporting, at KERN_ERR no less:
 > 
 > agpgart: Unsupported Intel chipset (device id 254c)
 > 
 > Now, of course it says this, as this device does not present itself as
 > AGP-capable:
 > 
 > The patch below checks for a valid cap_ptr prior to printing the
 > message, now at KERN_WARNING level (it's not really an error, is it?)

indeed, patch applied.

Thanks,

		Dave

