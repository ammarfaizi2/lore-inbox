Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSFSWoQ>; Wed, 19 Jun 2002 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSFSWoP>; Wed, 19 Jun 2002 18:44:15 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:49287 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318043AbSFSWnx>; Wed, 19 Jun 2002 18:43:53 -0400
Date: Wed, 19 Jun 2002 23:43:40 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christopher Li <chrisl@gnuchina.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020619234340.A24016@redhat.com>
References: <20020619113734.D2658@redhat.com> <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <3D10E5FE.A3FA3AEF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D10E5FE.A3FA3AEF@zip.com.au>; from akpm@zip.com.au on Wed, Jun 19, 2002 at 01:13:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 01:13:50PM -0700, Andrew Morton wrote:

> > I have a silly question, where is that ext3 CVS? Under sourcefourge
> > ext2/ext3 or gkernel?
> 
> See http://www.zip.com.au/~akpm/linux/ext3/ - about halfway
> down the page.
> 
> btw, I merged all the ext3 htree stuff into 2.5.23 yesterday.  Haven't
> tested it much at all yet.

Well, it has some interesting properties, such as the hash function
being a constant:

+	return 80; /* FIXME: for test only */

which I assume was an artifact of some testing Christopher was doing.
:)

I'm checking out a proper hash function at the moment.

Cheers,
 Stephen
