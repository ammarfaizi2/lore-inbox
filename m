Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTFOQxv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTFOQxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:53:50 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:24070 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262383AbTFOQxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:53:49 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH 2.4.21] meye driver update
Date: Sun, 15 Jun 2003 19:06:56 +0200
User-Agent: KMail/1.5.2
References: <20030615163138.GD1857@deep-space-9.dsnet>
In-Reply-To: <20030615163138.GD1857@deep-space-9.dsnet>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306151906.57099.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 June 2003 18:31, Stelian Pop wrote:
> Hi,

Hi Stelian,

> +void dma_free_coherent(struct pci_dev *dev, size_t size,
                          ^^^^^^^^^^^^^^^^^^^
> +                         void *vaddr, dma_addr_t dma_handle)
                                         ^^^^^^^^^^^^^^^^^^^^^
Why do you define these unused parameters?
> +{
> +        free_pages((unsigned long)vaddr, get_order(size));
> +}

And why are they defined in 2.5, too, althought unused.
Is there some reason?

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 19:00:48 up  2:45,  2 users,  load average: 1.37, 1.13, 1.08

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7KexoxoigfggmSgRAsWrAKCBMmD+2hp5CIE00eoZNNNsXNKLdgCgitmg
NI+nrOdvLnEXmHFv7hopBNk=
=DaIp
-----END PGP SIGNATURE-----

