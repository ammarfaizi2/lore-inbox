Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbTCVNkJ>; Sat, 22 Mar 2003 08:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbTCVNkJ>; Sat, 22 Mar 2003 08:40:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42137
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262778AbTCVNkI>; Sat, 22 Mar 2003 08:40:08 -0500
Subject: Re: PATCH: fix proc handling in sis, siimageand slc90e66
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030322074911.A24305@infradead.org>
References: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk>
	 <20030322074911.A24305@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048345386.8911.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 15:03:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 07:49, Christoph Hellwig wrote:
> > +	
> > +	return len > count ? count : len;
> 
> Shouldn't this just move to the seq_file interface?  (probably the "simple"
> variant)

That means making the 2.4 and 2.5 drives diverge which is a pain I don't want 
before 2.6

