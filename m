Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTBOU7a>; Sat, 15 Feb 2003 15:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTBOU7a>; Sat, 15 Feb 2003 15:59:30 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:43275 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265786AbTBOU73>; Sat, 15 Feb 2003 15:59:29 -0500
Date: Sat, 15 Feb 2003 21:09:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       "Theodore T'so" <tytso@mit.edu>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Message-ID: <20030215210922.A24685@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Theodore T'so <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de> <200302151859.11370.agruen@suse.de> <20030215183959.B22045@infradead.org> <200302152017.03259.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302152017.03259.agruen@suse.de>; from agruen@suse.de on Sat, Feb 15, 2003 at 08:17:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 08:17:03PM +0100, Andreas Gruenbacher wrote:
> That sounds quite reasonable. I would have to raise CAP_SYS_ADMIN for 
> trusted EA's, though. Do you see any potential side effects while a 
> pretty powerful capability like CAP_SYS_ADMIN is temporarily raised?

Okay, something I missed when looking over your patches, otherwise I'd
have shutde earlier :)  Do you really think you want CAP_SYS_ADMIN for
trusted EAs?  Soon we'll get CAP_SYS_ADMIN as catchall like old suser()..

Let me check what XFS uses for that purpose as soon as I'm back in the
office.

