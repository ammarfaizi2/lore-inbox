Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbUK3PsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbUK3PsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUK3PsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:48:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262120AbUK3Pqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:46:53 -0500
Date: Tue, 30 Nov 2004 15:46:49 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041130154647.GV26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <20041130132619.GD4670@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041130132619.GD4670@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:26:19PM +0100, Pavel Machek wrote:
> > Think read(2)/write(2).  We already have several barfbags too many,
> > and that includes both ioctl() and setsockopt().  We are stuck with
> > them for compatibility reasons, but why the hell would we need yet
> > another one?
> 
> Passing structure using read/write is evil, because there's nowhere to hook 
> 32/64 bit translation.

No, really?  And we must use different layouts for 32 and 64 bit platforms
for which religious reasons, exactly?
