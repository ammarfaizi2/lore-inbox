Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTE0Phl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263867AbTE0Phk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:37:40 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:1745
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263854AbTE0Phj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:37:39 -0400
Date: Tue, 27 May 2003 11:50:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527155053.GB21744@gtf.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com> <1054047595.1975.64.camel@mulgrave> <20030527152113.GA21744@gtf.org> <1054049931.1975.129.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054049931.1975.129.camel@mulgrave>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:38:50AM -0400, James Bottomley wrote:
> Thus, if you never address ATA devices by the WWN, you probably never
> want to make it part of the addressing scheme.
> 
> Exporting a unique ID for userspace to use is a different (and probably
> orthogonal) issue.

Oh, no question.  My main interest is having a persistent id for a
device's media.  Then Linux can use that to allow mapping in case device
names or majors change at each boot (and similar situations).

	Jeff



