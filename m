Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSCZTJr>; Tue, 26 Mar 2002 14:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312695AbSCZTJe>; Tue, 26 Mar 2002 14:09:34 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:32951 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312626AbSCZTJY>; Tue, 26 Mar 2002 14:09:24 -0500
Date: Tue, 26 Mar 2002 19:47:24 +0100 (MET)
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org,
        Marc-Christian Petersen <mcp@linux-systeme.de>
Subject: Re: 2.4.18 problems
In-Reply-To: <3CA0BC00.54F608D6@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020326194457.6107C-100000@fps>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, Andrew Morton wrote:

Hi Andrew,

> > kernel: EXT3-fs warning (device ide0(3,10)): ext3_unlink: Deleting
> > nonexistent file (32650)
> > 
> > Since 2.4.18 i get sometimes the above message. What is it?
> > 
> 
> Well that's clever of you :)  According to google, only
> one other person has ever hit this with ext3.  Several
> people have hit it on ext2.  It does appear to be related
> to I/O errors on the underlying device.
:-( ... shit.
 
> Could you please force a fsck against that filesystem and
> also check you logs for any disk I/O warnings.
already done so, forced fsck and looked in the logs, but there are no I/O
Errors, but the ext3_unlink message. It appears more often the last hours
:-(

Kind regards,
	Marc

