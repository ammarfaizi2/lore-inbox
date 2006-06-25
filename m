Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWFYLH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWFYLH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWFYLH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:07:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41884 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932357AbWFYLHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:07:25 -0400
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read
	atip wiith cdrecord
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20060624144739.78bde590.akpm@osdl.org>
References: <200606242036.k5OKaSvp031813@fire-2.osdl.org>
	 <20060624144739.78bde590.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 13:07:23 +0200
Message-Id: <1151233643.4940.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 14:47 -0700, Andrew Morton wrote:
> > I simply try to use "cdrecord dev=ATAPI:1,0,0 -atip" as root.


one issue is that it's a lot better to use --dev=/dev/hda (or whatever
your cdrom device is.. usually even /dev/cdrom or /dev/cdwriter will
work, depends on your distro)... that is what most people use and that
is the interface that's actively supported and debugged...

