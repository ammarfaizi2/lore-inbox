Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTHFSig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270991AbTHFSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:38:35 -0400
Received: from mail.gondor.com ([212.117.64.182]:35340 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S270982AbTHFSiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:38:24 -0400
Date: Wed, 6 Aug 2003 20:38:22 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030806183822.GA6744@gondor.com>
References: <20030806150335.GA5430@gondor.com> <20030806110634.G7752@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806110634.G7752@schatzie.adilger.int>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 11:06:34AM -0600, Andreas Dilger wrote:
> Is this the root filesystem that is being checked?  If yes, then you
> probably need to either reboot after the fsck is complete (before
> mounting RW), or run the fsck from a rescue disk/CD.

No, it's not the root filesystem, but I usually check it while it's
mounted r/o, because the check takes nearly an hour and I want to give
the users at least read access to their files.

But because I assumed that this may cause problems, I did try it with a
completly unmonted filesystem once, without success.

Can you explain how a r/o mounted file system can cause problems?
Perhaps there is still some connection to my problem.

Jan

