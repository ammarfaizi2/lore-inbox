Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266924AbTGTOPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 10:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbTGTOPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 10:15:30 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:7621 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266924AbTGTOP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 10:15:28 -0400
Date: Sun, 20 Jul 2003 16:30:14 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Andrew Thompson <vagabond@raven-games.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Enabling SCSI emulation in 2.6 kernel causes lockups.
Message-ID: <20030720163014.A8404@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Andrew Thompson <vagabond@raven-games.com>,
	linux-kernel@vger.kernel.org
References: <1058708549.13241.11.camel@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058708549.13241.11.camel@vagabond>; from vagabond@raven-games.com on Sun, Jul 20, 2003 at 02:42:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [snip] I can enable basic SCSI support without a problem but if I
> enable the SCSI emulation, the SCSI Cd-Rom support and the generic SCSI
> support the kernel locks up as reported above.

ide-scsi is broken in 2.6-test, use ide-cd and get updated cdrtools.

See http://www.codemonkey.org.uk/post-halloween-2.5.txt

Rudo.
