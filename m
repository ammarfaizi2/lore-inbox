Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHJJPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHJJPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUHJJM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:12:56 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:53394 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263815AbUHJJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:12:24 -0400
Date: Tue, 10 Aug 2004 11:12:23 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810091223.GF10361@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2004-08-09:

> >We try, when they make sense...
> 
> You should learn what "make sense" means, Linux-2.6 is a clear move away from 
> the demands of a Linux user who likes to write CDs/DVDs.

Or so you think.

cdrecord dev=/dev/hdd ... on 2.6 has given me what 2.4 didn't do:
DMA for non-2048 block sizes.

I agree that I'd rather have seen ide-scsi fixed than yet another
interface extended, but if I use /dev/sg4 or /dev/hdd, doesn't really
matter.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
