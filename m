Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270518AbTGSIHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 04:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270515AbTGSIHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 04:07:52 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62472 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270519AbTGSIHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 04:07:49 -0400
Date: Sat, 19 Jul 2003 09:22:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030719092246.B19754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva> <1058569601.544.1.camel@teapot.felipe-alfaro.com> <20030719003824.GI2289@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030719003824.GI2289@matchmail.com>; from mfedyk@matchmail.com on Fri, Jul 18, 2003 at 05:38:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 05:38:24PM -0700, Mike Fedyk wrote:
> On Sat, Jul 19, 2003 at 01:06:41AM +0200, Felipe Alfaro Solana wrote:
> > On Fri, 2003-07-18 at 21:53, Marcelo Tosatti wrote:
> > > Hello,
> > > 
> > > Here goes -pre7.
> > 
> > Will ACL/xattr support get its way onto mainstream 2.4 soon?
> 
> Doubt it.
> 
> Unless it gets into -ac or -aa for a long while and a whole bunch of users
> clamor for it.

The VFS infrastructure for ACLs and the XFS ACL code is in -aa for a long
time.

> So, is acl only working with ext[23] & XFS?  What about reiserfs or jfs?

ACLs work with XFS, ext[23] and JFS in 2.4 and 2.4+patches.  In addition
SuSE ships patches for xattr/ACL on reiserfs but namesys doesn't like them.

