Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTLHNuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbTLHNuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:50:04 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:20232 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S265403AbTLHNt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:49:58 -0500
From: phillip@lougher.demon.co.uk
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: joern@wohnheim.fh-wedel.de, kbiswas@neoscale.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1070882901.31993.72.camel@hades.cambridge.redhat.com>
Subject: Re: partially encrypted filesystem
Date: Mon, 08 Dec 2003 13:49:57 +0000
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <E1ATLlt-000366-0Y@anchor-post-34.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dwmw2@infradead.org wrote:
> On Thu, 2003-12-04 at 18:20 +0000, Phillip Lougher wrote:
> > Considering that Jffs2 is the only writeable compressed filesystem, yes. 
> >   What should be borne in mind is compressed filesystems never expect 
> > the data after compression to be bigger than the original data.
> 
> In fact that assumption is fairly trivial to remove, if you can put an
> upper bound on the growth. Adding encryption of data to JFFS2 would
> actually be fairly trivial; encryption of metadata would be harder. 
> 

I was pointing out it had to be considered.  Modesty prevented me from mentioning that adding encryption of both data and metadata to Squashfs would be very easy :-)

Phillip


