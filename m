Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280635AbRKFWX2>; Tue, 6 Nov 2001 17:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280630AbRKFWXT>; Tue, 6 Nov 2001 17:23:19 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2629 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S280635AbRKFWXJ>; Tue, 6 Nov 2001 17:23:09 -0500
Date: Tue, 6 Nov 2001 21:48:21 +0000
From: Stephen Tweedie <sct@redhat.com>
To: m@mo.optusnet.com.au
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrew Morton <akpm@zip.com.au>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011106214821.N4137@redhat.com>
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <200111050554.fA55swt273156@saturn.cs.uml.edu> <3BE647F4.AD576FF2@zip.com.au> <20011105131636.C3957@lynx.no> <m1wv15ufn1.fsf@mo.optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1wv15ufn1.fsf@mo.optusnet.com.au>; from m@mo.optusnet.com.au on Tue, Nov 06, 2001 at 07:28:02AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 06, 2001 at 07:28:02AM +1100, m@mo.optusnet.com.au wrote:

> Another heuristic to try make be to only use a different blockgroup
> for when the mkdir()s are seperate in time.

If I'm creating a hierarchy with "tar xvzf", why am I doing it?  I
might be unpacking a source tree where all the files are going to be
used together.  But I might be restoring a backup of /home.  Assuming
that we want a compact unpacking is not always going to be correct.

Cheers,
 Stephen
