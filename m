Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268844AbRHFQM2>; Mon, 6 Aug 2001 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268843AbRHFQMT>; Mon, 6 Aug 2001 12:12:19 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:5181 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S268841AbRHFQMH>; Mon, 6 Aug 2001 12:12:07 -0400
Date: Mon, 6 Aug 2001 19:11:46 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: dave-mlist@bfnet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: looking for resources for designing loopback filesystem
Message-ID: <20010806191146.D58023@niksula.cs.hut.fi>
In-Reply-To: <5.1.0.14.2.20010803232810.0415b840@pop.cus.cam.ac.uk> <ygehevl5i0s.fsf_-_@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ygehevl5i0s.fsf_-_@bfnet.com>; from dave-mlist@bfnet.com on Mon, Aug 06, 2001 at 08:23:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 08:23:47AM -0700, you [dave-mlist@bfnet.com] claimed:
> I'd like to create a filesystem which mirrors another local
> filesystem, but with different permissions, and with some content
> invisible to some users.  Is there a kernel module that does this
> already?  Is the loopback module the one?  If so, where can I learn
> about applying the module to this purpose?

Perhaps you could hack an nfs-server (knfsd or nfsd) to do the permission
tweaks and hiding and then just mount the stuff over to another location
with ordinary nfs client stuff.


-- v --

v@iki.fi
