Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVALObQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVALObQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVALObQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:31:16 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:62619 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261200AbVALObM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:31:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=pT+AqJUVGj7mci8urfeNrHQ6bocgPX6zj0P0mxY56bnAQBL0XS/o54vzsbq9z/K++pEVZvSwl19l97mAN5FddCWbfRXDLGS/HtjBfV3xn16NEZmCC44p9jRY+f9U5ue+RyDQK0aKh43YoRwsLYp/YugwqmEeN2n2G8H4AyoCHgg=
Date: Wed, 12 Jan 2005 15:31:31 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: kinema@gmail.com, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
Message-Id: <20050112153131.1f778264.diegocg@gmail.com>
In-Reply-To: <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
References: <loom.20041231T155940-548@post.gmane.org>
	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>
	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 12 Jan 2005 14:49:35 +0100 Miklos Szeredi <miklos@szeredi.hu> escribió:


> So if any of you would like to support this motion, you can mail the
> linux-kernel list and maybe Linus and Andrew, to generate a little
> discussion on why (or why not) inclusion is a good idea.


Personally I think it's cool for "desktops" and other reasons because:

-It could replace gnome-vfs AND kioslaves by a more generic solution that works
 for all environments

-You could implement several "not-performance-critical" filesystems (fat,
 isofs) with FUSE to avoid possible security issues. Give that nowadays 
 usb sticks and cd/dvds are so common it'd be possible to modify a filesystem
 on purpose to crash the kernel if a bug were found in those filesytems. With
 FUSE that posibility decreases.

-Since you can use other programming languages, I suposse it'd be easier for
 people to write support for weird filesystems.

-Better for kernel (less code to maintain given a big number of filesystems)
 and less pressure for VFS developers when making big changes to the VFS.

-Possibility to write stupid filesystems like "gmailfs".
 
