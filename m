Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUI2OgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUI2OgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUI2O3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:29:14 -0400
Received: from open.hands.com ([195.224.53.39]:46720 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268452AbUI2OZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:25:00 -0400
Date: Wed, 29 Sep 2004 15:35:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to allow sys_pread64 and sys_pwrite64 to be used from modules
Message-ID: <20040929143555.GA25982@lkcl.net>
References: <20040929125835.GA6764@lkcl.net> <1096462770.2786.35.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096462770.2786.35.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 02:59:30PM +0200, Arjan van de Ven wrote:
> On Wed, 2004-09-29 at 14:58, Luke Kenneth Casson Leighton wrote:
> > i do not know if this does any damage (and i'm going to find out!)
> > 
> > i seek to use these two functions from an experimental kernel module: i
> > get warnings about "symbol not found" without this patch:
> > 
> 
> what on earth are you doing in your module??????
 
 prefixing a new root onto the front of the file name and then
 re-issuing (proxying) a request.
 
 all file requests, all stats, all opendirs, everything.

 i'm hacking fuse in an attempt to remove the userspace bits,
 merging the functionality of the userspace "fusexmp" - fuse
 example program - into the fuse kernel module.

 l.

 p.s.  if someone fixes the ioctl bug BLKRRDPART on a usb scsi
	   storage device which has been umounted with a "-l"
	   option, then i don't have to do all this work.

	 bugs.debian.org no #273055.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

