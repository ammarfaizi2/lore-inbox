Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSFSTJ7>; Wed, 19 Jun 2002 15:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317979AbSFSTJ6>; Wed, 19 Jun 2002 15:09:58 -0400
Received: from 12-234-169-113.client.attbi.com ([12.234.169.113]:48593 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S317978AbSFSTJ5>; Wed, 19 Jun 2002 15:09:57 -0400
Date: Wed, 19 Jun 2002 13:03:38 -0400 (EDT)
From: Christopher Li <chrisl@gnuchina.org>
X-X-Sender: chrisl@localhost.localdomain
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
In-Reply-To: <20020619113734.D2658@redhat.com>
Message-ID: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jun 2002, Stephen C. Tweedie wrote:

> Hi,
> 
> On Tue, Jun 18, 2002 at 06:18:49PM -0400, Alexander Viro wrote:
>  
> > IOW, making sure that empty blocks in the end of directory get freed
> > is a matter of 10-20 lines.  If you want such patch - just tell, it's
> > half an hour of work...
> 
> It's certainly easier at the tail, but with htree we may have
> genuinely enormous directories and being able to hole-punch arbitrary
> coalesced blocks could be a huge win.  Also, doing the coalescing
I would can contribute on that. I am thinking about it anyway.
Daniel might already has some code there.

I have a silly question, where is that ext3 CVS? Under sourcefourge
ext2/ext3 or gkernel?

Chris


