Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbREOUS2>; Tue, 15 May 2001 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbREOUSS>; Tue, 15 May 2001 16:18:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261432AbREOUSK>; Tue, 15 May 2001 16:18:10 -0400
Message-ID: <3B018EF3.F9DF7207@transmeta.com>
Date: Tue, 15 May 2001 13:17:55 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <Pine.GSO.4.21.0105151615230.21081-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> >
> > None whatsoever.  The one thing that matters is that noone starts making
> > the assumption that mapping->host->i_mapping == mapping.
> 
> One actually shouldn't assume that mapping->host is an inode.
> 

What else could it be, since it's a "struct inode *"?  NULL?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
