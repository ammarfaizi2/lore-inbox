Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWEKQQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWEKQQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWEKQQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:16:51 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:13291 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030314AbWEKQQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:16:50 -0400
Date: Thu, 11 May 2006 17:16:40 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: ata_piix failure on ich6m
Message-ID: <20060511161640.GA24338@srcf.ucam.org>
References: <20060510235650.GA20206@srcf.ucam.org> <44629E68.3020302@gmail.com> <20060511081140.GA21594@srcf.ucam.org> <20060511084541.90d4e071.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511084541.90d4e071.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 08:45:41AM -0700, Randy.Dunlap wrote:

> Does the 'combined_mode' kernel parameter help any?

Hmm. Slightly awkward to check - it's a modular system with libata in 
initramfs, so getting parameters in may be a pain. However, there's 
nothing on the legacy IDE controller - should combined mode actually 
make a difference in that case? As I said, ahci works fine - the problem 
only occurs with ata_piix. The MAP register indicates that combined mode 
isn't in use.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
