Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267067AbRGJSaQ>; Tue, 10 Jul 2001 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267069AbRGJS34>; Tue, 10 Jul 2001 14:29:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:64207 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267068AbRGJS3y>; Tue, 10 Jul 2001 14:29:54 -0400
Date: Tue, 10 Jul 2001 19:29:26 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mike Black <mblack@csihq.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Message-ID: <20010710192926.D1493@redhat.com>
In-Reply-To: <200107101752.f6AHqXUu022141@webber.adilger.int> <018101c1096a$17e2afc0$b6562341@cfl.rr.com> <20010710191719.B1493@redhat.com> <01cb01c1096d$e9052bc0$b6562341@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01cb01c1096d$e9052bc0$b6562341@cfl.rr.com>; from mblack@csihq.com on Tue, Jul 10, 2001 at 02:27:00PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2001 at 02:27:00PM -0400, Mike Black wrote:
> So it sounds like theres no advantage then to a swap partition vs file?

There are --- the cost of accessing the metadata to do the file
blocknr lookup, and the fragmentation you can get on files, both add
to their cost compared to partitions.

Cheers,
 Stephen
