Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284335AbRLEMgp>; Wed, 5 Dec 2001 07:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284338AbRLEMgf>; Wed, 5 Dec 2001 07:36:35 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34542
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284335AbRLEMg0>; Wed, 5 Dec 2001 07:36:26 -0500
Date: Wed, 5 Dec 2001 04:36:18 -0800
To: Florian Lohoff <flo@rfc822.org>
Cc: Andrew Morton <akpm@zip.com.au>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-0.9.16 against linux-2.4.17-pre2
Message-ID: <20011205123618.GA8966@mikef-linux.matchmail.com>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>,
	Andrew Morton <akpm@zip.com.au>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <20011205133204.C4916@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205133204.C4916@paradigm.rfc822.org>
User-Agent: Mutt/1.3.24i
From: Mike Fedyk <mfedyk@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 01:32:04PM +0100, Florian Lohoff wrote:
> On Sun, Dec 02, 2001 at 09:51:01PM -0800, Andrew Morton wrote:
> > 
> > An ext3 update which also applies to linux-2.4.16 is available at
> > 
> 
> It seems something broken between 2.4.15-pre2 and this update - I am
> seeing filesystem corruption:
>

Hmm, that's strange.

> I am backing out the 2417 changes now - I already did a forced fsck
> which (e2fs 1.25) which didnt find anything abnormal.
> 
> (flo@ping)~# uname -a
> Linux ping.mediaways.net 2.4.16 #1 Tue Dec 4 19:42:30 CET 2001 i686 unknown
> 

Did you apply it against 2.4.16?  It was meant for 2.4.17-pre2.  Andrew, do
you know if that could be the cause of this problem?

Mike

