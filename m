Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280857AbRKBWeM>; Fri, 2 Nov 2001 17:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280858AbRKBWeB>; Fri, 2 Nov 2001 17:34:01 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:20574 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S280857AbRKBWdp>; Fri, 2 Nov 2001 17:33:45 -0500
Date: Fri, 2 Nov 2001 22:35:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Weird /proc/meminfo output on 2.4.13-ac5
In-Reply-To: <20011102132006.A5955@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.21.0111022231220.2582-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Mike Fedyk wrote:
> On Fri, Nov 02, 2001 at 07:34:49PM +0000, Petr Vandrovec wrote:
> > On  2 Nov 01 at 14:10, Andreas Franck wrote:
> > > $ cat /proc/meminfo
> > > Cached:       4294741680 kB     <------ This is impossible, i think? :-)
> > 
> > I'll upgrade to -ac6 and I'll see.
> 
> It won't help.  You'll need a patch that rik has posted a few days ago.
> 
> This problem is for 2.4.13, 2.4.13-acX, and 2.4.14pre*.

I believe that problem only applied to 2.4.13-acX, and arose because
an inappropriate part of 2.4.13 (relating to blockdev in pagecache) crept
into 2.4.13-acX.  2.4.13 and 2.4.14-preX should not need Rik's patch.

Hugh

