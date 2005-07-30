Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVG3Riv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVG3Riv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVG3Riu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:38:50 -0400
Received: from mail.murom.net ([213.177.124.17]:22934 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S263084AbVG3Rh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:37:57 -0400
Date: Sat, 30 Jul 2005 21:37:28 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [git patches] 2.4.x SATA update
Message-Id: <20050730213728.58d4b667.vsu@altlinux.ru>
In-Reply-To: <42E93618.2070902@pobox.com>
References: <42E93618.2070902@pobox.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__30_Jul_2005_21_37_28_+0400_bO.hKHWL7lGuX_rG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__30_Jul_2005_21_37_28_+0400_bO.hKHWL7lGuX_rG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 28 Jul 2005 15:46:32 -0400 Jeff Garzik wrote:

> +/**
> + *	ata_sg_init_one - Associate command with memory buffer
> + *	@qc: Command to be associated
> + *	@buf: Memory buffer
> + *	@buflen: Length of memory buffer, in bytes.
> + *
> + *	Initialize the data-related elements of queued_cmd @qc
> + *	to point to a single memory buffer, @buf of byte length @buflen.
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host_set lock)
> + */
> +
> +
> +
> +/**
> + *	ata_sg_init_one - Prepare a one-entry scatter-gather list.
> + *	@qc:  Queued command
> + *	@buf:  transfer buffer
> + *	@buflen:  length of buf
> + *
> + *	Builds a single-entry scatter-gather list to initiate a
> + *	transfer utilizing the specified buffer.
> + *
> + *	LOCKING:
> + */

Which one of the above duplicated comments for ata_sg_init_one is
correct?

> +/**
> + *	ata_sg_init - Associate command with scatter-gather table.
> + *	@qc: Command to be associated
> + *	@sg: Scatter-gather table.
> + *	@n_elem: Number of elements in s/g table.
> + *
> + *	Initialize the data-related elements of queued_cmd @qc
> + *	to point to a scatter-gather table @sg, containing @n_elem
> + *	elements.
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host_set lock)
> + */
> +
> +
> +/**
> + *	ata_sg_init - Assign a scatter gather list to a queued command
> + *	@qc:  Queued command
> + *	@sg:  Scatter-gather list
> + *	@n_elem:  length of sg list
> + *
> + *	Attaches a scatter-gather list to a queued command.
> + *
> + *	LOCKING:
> + */

More duplicated comments.

--Signature=_Sat__30_Jul_2005_21_37_28_+0400_bO.hKHWL7lGuX_rG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC67rcW82GfkQfsqIRAuwnAJ4qx0W4ZHVY7Qa0Hq+4VgcGSDS/zgCgi0dn
Rj7afwWEhtXIlJdnCmJOdto=
=HOdf
-----END PGP SIGNATURE-----

--Signature=_Sat__30_Jul_2005_21_37_28_+0400_bO.hKHWL7lGuX_rG--
