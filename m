Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKNOB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTKNOB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:01:58 -0500
Received: from havoc.gtf.org ([63.247.75.124]:58497 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262566AbTKNOB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:01:56 -0500
Date: Fri, 14 Nov 2003 09:01:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>, Jason Holmes <jholmes@psu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
Message-ID: <20031114140151.GA15315@gtf.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC1B1@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC1B1@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:00:15AM -0500, Mukker, Atul wrote:
> Matt,
> Can what is "normal PCI probing" mechanism.

struct pci_driver and struct pci_device_id.  Docs in
Documentation/pci.txt under "new-style drivers".

	Jeff



