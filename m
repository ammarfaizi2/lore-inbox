Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTKKLxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 06:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTKKLxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 06:53:20 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:57860 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263467AbTKKLxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 06:53:18 -0500
Date: Tue, 11 Nov 2003 12:53:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Flavio Bruno Leitner <fbl@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE disk information changed from 2.4 to 2.6
Message-ID: <20031111115316.GB16163@win.tue.nl>
References: <20031105184203.GG5304@conectiva.com.br> <Pine.SOL.4.30.0311052031510.1988-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0311052031510.1988-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 08:41:58PM +0100, Bartlomiej Zolnierkiewicz wrote:

> In 2.6.x it doesn't even read BIOS info (which is wrong IMO, it should
> do this but only as last resort - if partition can't be mounted).

How can reading information that is not used by any kernel
help in mounting a partition?

> Difference in CHS translation should matter only if you have some old DOS
> partitions created using CHS information.  Then you can force geometry
> using boot parameter "hd?=".  Unfortunately I've seen recently bugreport
> when 2.4.20 (?) works and 2.6.x fails even with forced geometry.

Fails? What do you mean?

(Are you referring to the problem of finding the last cylinder?)

Andries

