Return-Path: <linux-kernel-owner+w=401wt.eu-S1751043AbXARUqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbXARUqe (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 15:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXARUqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 15:46:34 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:38074 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXARUqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 15:46:32 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UgBTT16IcAGZ5TlsDdNODeOPNnC4zQIYZgT7jFJbrKMkrB/nLOH+MfUvhG9kj06/MAsvIu2JrWCuIUqrNRm1WfLwqB0SL9DSyXzbOZ3RWkyN9DP0sM/5/0BBo3F8SgsWqHzSExSuX37bcoyL7166qC9AfhvsN5RGODIEW+OROxA=
Message-ID: <a02278b00701181246y51c04491k9d6d0be3c6c693a2@mail.gmail.com>
Date: Thu, 18 Jan 2007 12:46:31 -0800
From: "Allexio Ju" <allexio.ju@gmail.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linas@austin.ibm.com,
       yanmin.zhang@intel.com
Subject: Re: Questions on PCI express AER support in HBA driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a02278b00701181146o2384d62ah8445ec3bb846a8da@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What are the expected changes on SCSI LLD driver in regards to PCIE
> AER supporting? I understood that the driver need to call following
> APIs during probing to enable AER support for the device,
> ---
> if (pci_find_aer_capability(dev)) {
>    pci_enable_pcie_error_reporting(dev);
> }
> ---
> What else does SCSI LLD driver need to changed?
Can anyone provide comment?

Allexio
