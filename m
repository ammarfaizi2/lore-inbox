Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287927AbSABTfK>; Wed, 2 Jan 2002 14:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287923AbSABTfA>; Wed, 2 Jan 2002 14:35:00 -0500
Received: from ns.caldera.de ([212.34.180.1]:6845 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287925AbSABTet>;
	Wed, 2 Jan 2002 14:34:49 -0500
Date: Wed, 2 Jan 2002 20:34:38 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Andrew Clausen <clausen@gnu.org>
Cc: linux-kernel@vger.kernel.org, bug-parted@gnu.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] userspace discovery of partitions
Message-ID: <20020102203438.A18445@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andrew Clausen <clausen@gnu.org>, linux-kernel@vger.kernel.org,
	bug-parted@gnu.org, evms-devel@lists.sourceforge.net
In-Reply-To: <20020102055735.C472@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102055735.C472@gnu.org>; from clausen@gnu.org on Wed, Jan 02, 2002 at 05:57:35AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:57:35AM +1100, Andrew Clausen wrote:
> When partprobe/libparted are compiled with --enable-discover-only
> --disable-nls etc (see README), it comes to about 73k (35k
> compressed), not including libc or libuuid.  Unfortunately, this is
> still quite large to be including in things like initramfs.  Is
> it worth paying this price?

Nope - I'd much prefer aeb's small partx for the same job :)
In fact it can be cut down even more than the current version. which is
30k dynamically linked against glibc.  In fact a striped down version
wouldn't need a libc so this would be about the size.

It supports dos, solaris, unixware and bsd partitions so far.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
