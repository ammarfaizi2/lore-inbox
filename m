Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRJEXW0>; Fri, 5 Oct 2001 19:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274522AbRJEXWR>; Fri, 5 Oct 2001 19:22:17 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8437
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274524AbRJEXWD>; Fri, 5 Oct 2001 19:22:03 -0400
Date: Fri, 5 Oct 2001 16:22:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Hans Reiser <reiser@namesys.com>, Bernd Eckenfels <ecki@lina.inka.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
Message-ID: <20011005162226.A797@mikef-linux.matchmail.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Hans Reiser <reiser@namesys.com>,
	Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <706340000.1002116485@gullevek.piwi.intern> <E15oqKN-00058k-00@calista.inka.de> <20011005113146.B3587@redhat.com> <3BBD8E82.592130A7@namesys.com> <20011005122536.C2293@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011005122536.C2293@redhat.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 12:25:36PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, Oct 05, 2001 at 02:42:10PM +0400, Hans Reiser wrote:
> 
> > > Should be fine with ext3 and XFS.  It's not a journaling problem as
> > > much as NFS assuming a particular property of the filesystem.
> 
> > Err, I meant it is stable from all reports for recent kernels:-/.... excuse me.
> 
> Yes, and it's also worth noting that this same NFS assumption will
> break exports of _all_ filesystems which don't have simple static
> inum/filehandle capabilities.  Reiserfs should work just fine now but
> the same NFS problem is still present if you do other things such as
> trying to re-export a SMB mount as NFS. 
> 

Yes, this issue has been reported many times on the samba mailing lists...

Are there any network filesystems on linux that have the "static
inum/filehandle capabilities"?
