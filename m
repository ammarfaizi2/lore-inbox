Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTKJJwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 04:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTKJJwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 04:52:50 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:39654
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263101AbTKJJwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 04:52:49 -0500
Date: Mon, 10 Nov 2003 10:52:48 +0100
From: "Oliver M. Bolzer" <oliver@gol.com>
To: linux-kernel@vger.kernel.org
Subject: Success with  Promise FastTrak S150 TX4 (Re: [BK PATCHES] libata fixes)
Message-ID: <20031110095248.GA20497@magi.fakeroot.net>
References: <20031108172621.GA8041@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108172621.GA8041@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 12:26:21PM -0500, Jeff Garzik <jgarzik@pobox.com> wrote...
 
> <jgarzik@redhat.com> (03/11/06 1.1415)
>    [libata] fix ugly Promise interrupt masking bug

This solved the last outstanding problem with the 4th drive and the
driver seems to find all drives and properly boot off them, at least
in a situation where no RAID-functionalty of the card is used. Great
Work.

# A first quick run of bonnie++ seems to show 2.6.0-test9+libata several
# %s slower then 2.4.22+ft3xx, but that might be related to differences
# between 2.4 and 2.6.

-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
