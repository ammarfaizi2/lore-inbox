Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272865AbRIXVfr>; Mon, 24 Sep 2001 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272829AbRIXVfh>; Mon, 24 Sep 2001 17:35:37 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.121.85]:45560 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S272758AbRIXVf1>; Mon, 24 Sep 2001 17:35:27 -0400
Date: Mon, 24 Sep 2001 16:35:46 -0500
From: J Troy Piper <jtp@dok.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924163546.C244@dok.org>
Mime-Version: 1.0
Content-Type: message/rfc822
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Mon, 24 Sep 2001 16:18:29 -0500
From: J Troy Piper <jtp@dok.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.10
Message-ID: <20010924161829.A244@dok.org>
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAECC4F.EF25393@zip.com.au>; from akpm@zip.com.au on Sun, Sep 23, 2001 at 11:01:51PM -0700
Return-Path: <jtp@dok.org>

On Sun, Sep 23, 2001 at 11:01:51PM -0700, Andrew Morton wrote:
> An ext3 patch against linux 2.4.10 is at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
> 
> This patch is *lightly tested* - ie, it boots and does stuff.
> The changes to ext3 are small, but the kernel which it patches
> has recently changed a lot.  If you're cautious, please wait
> a couple of days.
> 
> The patch retains the buffer-tracing code.  This will soon be
> broken out into a separate patch to make ext3 suitable for
> submission for the mainstream kernel.
> 


Hey Andrew,

Any more progress on my journal_revoke BUG?  Strangely enough, I've been 
mounting the drives as ext2 to try and avoid the errors, but I *STILL* hit 
the BUG when untar'ing a large file, or compiling a large file (ie. kernel 
source), which is somewhat unnerving.

---

/************************/
/*    J. Troy Piper     */
/*    <jtp@dok.org>     */
/* Ignotum per Ignotius */
/************************/

