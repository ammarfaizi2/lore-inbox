Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWDEREg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWDEREg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWDEREg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:04:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54713 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751285AbWDEREf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:04:35 -0400
Date: Wed, 5 Apr 2006 18:04:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405170434.GM27946@ftp.linux.org.uk>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com> <20060405153957.GI27946@ftp.linux.org.uk> <9e4733910604050843h3f6d0cdai8bfa3888b645c9b3@mail.gmail.com> <20060405154629.GJ27946@ftp.linux.org.uk> <9e4733910604050918s72fc16acla569c6f244e01b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910604050918s72fc16acla569c6f244e01b9e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 12:18:07PM -0400, Jon Smirl wrote:
> On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > On Wed, Apr 05, 2006 at 11:43:15AM -0400, Jon Smirl wrote:
> > > > How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
 ~~~~~
> >               ^^^^^^^^^^^^^^^^^
> 
> Where does this file come from? A device node?
> 
> 
> > > > of your own?  ~20 lines for all of it, not counting #include...
        ~~~~~~~~~~~

Are you really incapable of understanding a simple sentence?
