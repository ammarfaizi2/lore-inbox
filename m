Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTEGTZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTEGTY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:24:59 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13584
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264219AbTEGTYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:24:39 -0400
Date: Wed, 7 May 2003 12:37:12 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 NFS close-to-open question
Message-ID: <20030507193712.GI8350@matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
References: <20030427151201.27191.qmail@web12802.mail.yahoo.com> <shshe8k6ijs.fsf@charged.uio.no> <20030506022813.GB8350@matchmail.com> <16055.44973.106804.436859@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16055.44973.106804.436859@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 02:50:53PM +0200, Trond Myklebust wrote:
> >>>>> " " == Mike Fedyk <mfedyk@matchmail.com> writes:
> 
>      > Might that cause this too:
> 
>      > May 5 15:32:10 fileserver kernel: lockd: can't encode
>      > arguments: 5
> 
> No.
> 
>      > 2.4.21-rc1-rmap15g is giving the above error, and
>      > 2.4.20-rmap15e is not.  I'll leave it on 2.4.20-rmap15e for now
>      > and let you know if there are any errors on that one too.
> 
> I'm confused. Are the rmap patches making changes to lockd?
> I certainly don't see the above errors in standard 2.4.21-rc1.

Oh, one more thing.

This is output from a server running 2.4.19-freeswan mounting an nfs export
from a reiserfs based 112GB export using 2.4.21-rc1-freeswan-rmap.  When the
112GBs are exported from 2.4.20-freeswan-rmap, there is no error.

I will retest, but I hope this isn't a bug making it through the pre & rc
process.
