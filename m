Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUHJNbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUHJNbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHJNaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:30:09 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:54677 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265263AbUHJN3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:29:53 -0400
Date: Tue, 10 Aug 2004 15:29:52 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: =?iso-8859-15?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810132952.GA32212@merlin.emma.line.org>
Mail-Followup-To: =?iso-8859-15?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de> <20040810084159.GD10361@merlin.emma.line.org> <20040810101123.GB2743@harddisk-recovery.com> <yw1xsmav8b79.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsmav8b79.fsf@kth.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Måns Rullgård wrote:

> Problems with ATAPI devices on Promise cards are common, even Promise
> admits that.

Data point: Plextor PX-W4824A on PDC-20265R (Gigabyte 7ZX-R) in ATA mode
is completely non-functional. Promise chips of that age will also lock
up with legacy ATA queued commands (tried with a DTLA under FreeBSD ->
boom).

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
