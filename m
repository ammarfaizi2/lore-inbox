Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbREOVWs>; Tue, 15 May 2001 17:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbREOVWi>; Tue, 15 May 2001 17:22:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22026 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261558AbREOVWe>; Tue, 15 May 2001 17:22:34 -0400
Message-ID: <3B019E10.B1C48EDB@transmeta.com>
Date: Tue, 15 May 2001 14:22:24 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <Pine.GSO.4.21.0105151628340.21081-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> void *.
> 
> Look, methods of your address_space certainly know what they hell they
> are dealing with. Just as autofs_root_readdir() knows what inode->u.generic_ip
> really points to.
> 
> Anybody else has no business to care about the contents of ->host.
> 

Why do we need a ->host at all, then?  Why not simply make it a private
pointer?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
