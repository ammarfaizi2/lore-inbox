Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbRGKWjE>; Wed, 11 Jul 2001 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266846AbRGKWiy>; Wed, 11 Jul 2001 18:38:54 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:56594
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S266839AbRGKWio>; Wed, 11 Jul 2001 18:38:44 -0400
Date: Wed, 11 Jul 2001 18:37:45 -0400
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolinux.com>
cc: Shawn Veader <shawn.veader@zapmedia.com>, linux-kernel@vger.kernel.org
Subject: Re: disk full or not?  you decide...
Message-ID: <264310000.994891065@tiny>
In-Reply-To: <Pine.LNX.4.33L.0107111909140.9899-100000@imladris.rielhome.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, July 11, 2001 07:10:27 PM -0300 Rik van Riel
<riel@conectiva.com.br> wrote:

> On Wed, 11 Jul 2001, Andreas Dilger wrote:
> 
>> Note also that on reiserfs, if you have such a process which keeps
>> files open after they are deleted and then you have a crash, the file
>> is "orphaned" and the space is "lost" until you run reiserfsck again.
>> It may be that Chris Mason's patch for this is in the latest kernels,
>> but it may not be, and it might not be in the kernel you are running.
> 
> Chris, Hans,  is this problem still in the reiserfs
> in the current kernel or has it already been fixed ?

Vladimir Saveliev has a patch that is doing well in internal testing.  I
had wanted to intergrate it some nested transaction stuff, but it didn't
have the same advantages as it did under 2.2.x.

They will probably send it out for wider testing very soon.

Just to clarify, you need to have a crash or unclean un
-chris

