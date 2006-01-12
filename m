Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWALNVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWALNVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWALNVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:21:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41380 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030397AbWALNVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:21:41 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Arjan van de Ven <arjan@infradead.org>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
In-Reply-To: <43C65196.8040402@suse.de>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>
	 <43C5B59C.8050908@us.ibm.com>  <43C65196.8040402@suse.de>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 14:21:28 +0100
Message-Id: <1137072089.2936.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   privcmd returns a filehandle which is then used 
> for ioctls (misc char dev maybe?). 


EWWWWWWWWWWWWWW

what is wrong with open() ?????
things that return fd's that aren't open() (or dup and socket) are just
evil. Esp if it's in proc or sysfs.


