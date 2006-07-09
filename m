Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161155AbWGIVIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWGIVIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWGIVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:07:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25772 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161155AbWGIVH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:07:58 -0400
Subject: Re: [RFC][PATCH 1/2] firmware version management: add
	firmware_version()
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Martin Langer <martin-langer@gmx.de>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <200607092109.02707.mb@bu3sch.de>
References: <20060708130904.GA3819@tuba>
	 <1152457310.3255.58.camel@laptopd505.fenrus.org>
	 <20060709152516.GB3678@tuba>  <200607092109.02707.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 23:07:53 +0200
Message-Id: <1152479273.3255.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 21:09 +0200, Michael Buesch wrote:
> On Sunday 09 July 2006 17:25, you wrote:
> > > yes it does. bcm43xx asks userspace to upload firmware (via
> > > request_firmware() ) and a userspace app (udev most of the time) will
> > > upload it. That app, eg udev, can do the md5sum and checking it against
> > > a list of "known good" firmwares. Voila problem solved ;)
> > 
> > I see. It's an interesting way that I didn't noticed. 
> > Thanks for the guidance.
> 
> Nono, stop. Not too fast. :)
> Where is this "list of "known good" firmwares" actually stored?
> In userspace (udev)? That would be guaranteed to be out of sync
> with the driver.

for all I care it's part of the kernel tarbal somehow

but a real file, not some in kernel memory eating thing

