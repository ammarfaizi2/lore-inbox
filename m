Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTKLDoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKLDoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:44:23 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63502
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261473AbTKLDoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:44:21 -0500
Date: Tue, 11 Nov 2003 19:44:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031112034422.GH2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>,
	linux-kernel@vger.kernel.org
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au> <HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com> <20031112002811.GA18177@tc.pci.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112002811.GA18177@tc.pci.uni-heidelberg.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 01:28:11AM +0100, Bernd Schubert wrote:
> On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
> > Hello Peter,
> > 
> > Forgive another quick Q or two.
> > 
> > What is the maximum partition size for a patched 2.4.x kernel,
> > and where are those patches?
> > 
> 
> Hello,
> 
> Are 2TB possible with an unpatched 2.4.x 64bit-AMD64 kernel? The
> partion is supposed to be reiserfs. I read an about 2 years old
> discussion about this and Hans Reiser statet that the maximum size is
> about 2GB. Unfortunality I don't know what this 'about' depends on.

That would refer to the Reiserfs 3.5 format, which is limited to 2GB max
file sizes.  If you use 2.4, and have never used a 2.2 reiserfs kernel, then
you probably have the 3.6 format that has a much larger limit.
