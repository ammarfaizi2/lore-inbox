Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRCQBJq>; Fri, 16 Mar 2001 20:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRCQBJg>; Fri, 16 Mar 2001 20:09:36 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5897 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131477AbRCQBJb>; Fri, 16 Mar 2001 20:09:31 -0500
Date: Fri, 16 Mar 2001 20:09:12 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Neal Gieselman <Neal.Gieselman@Visionics.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cannot delete dir
In-Reply-To: <D0FA767FA2D5D31194990090279877DA573588@dbimail.digitalbiometrics.com>
Message-ID: <Pine.LNX.4.33.0103162008000.835-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Neal Gieselman wrote:

>Date: Fri, 16 Mar 2001 10:42:40 -0600
>From: Neal Gieselman <Neal.Gieselman@Visionics.com>
>To: linux-kernel@vger.kernel.org
>Content-Type: text/plain
>Subject: Cannot delete dir
>
>Excuse me, but can anyone tell me how I might delete a directory on a Redhat
>6.1 ext2 file
>system that has permissions drwS--sr-x?  Even as root I cannot unlink the
>directory.

What does "lsattr" say?  I'll bet you've had some fs corruption
and some extended attributes are enabled.  Also be sure to look
at the attributes of the parent directory as well.

man lsattr
man chattr

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
There are two major products that come out of Berkeley: LSD and BSD.
We don't believe this to be a coincidence.
   -- Jeremy S. Anderson

