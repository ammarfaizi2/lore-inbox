Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRCSWBi>; Mon, 19 Mar 2001 17:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRCSWBb>; Mon, 19 Mar 2001 17:01:31 -0500
Received: from [64.64.109.142] ([64.64.109.142]:14853 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131644AbRCSWBQ>; Mon, 19 Mar 2001 17:01:16 -0500
Message-ID: <3AB68141.F0FFBCE9@didntduck.org>
Date: Mon, 19 Mar 2001 16:59:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux should better cope with power failure
In-Reply-To: <Pine.LNX.3.95.1010319162020.12070A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Mon, 19 Mar 2001, Brian Gerst wrote:
> [SNIPPED...]
> 
> >
> > At the very least the disk should be consistent with memory.  If the
> > dirty pages aren't written back to the disk (but not necessarily removed
> > from memory) after a reasonable idle period, then there is room for
> > improvement.
> >
> 
> Hmmm. Now think about it a minute. You have a database operation
> with a few hundred files open, most of which will be deleted after
> a sort/merge completes. At the same time, you've got a few thousand
> directories with their ATIME being updated. Also, you have thousands
> of temporary files being created in /tmp during a compile that didn't
> use "-pipe".
> 
> If you periodically write everything to disk, you don't have many
> CPU cycles available to do anything useful.

Note the key words "reasonable idle period".  It was stated elsewhere
that this is the case already so it is a moot point.

--

				Brian Gerst
