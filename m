Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135895AbRDZTVF>; Thu, 26 Apr 2001 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135896AbRDZTU5>; Thu, 26 Apr 2001 15:20:57 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:7429 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135895AbRDZTUw>; Thu, 26 Apr 2001 15:20:52 -0400
Date: Thu, 26 Apr 2001 15:20:20 -0400
From: Chris Mason <mason@suse.com>
To: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
cc: reiser@idiom.com
Subject: Re: ReiserFS question
Message-ID: <242950000.988312820@tiny>
In-Reply-To: <E14sr4v-000EC4-00@f3.mail.ru>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, April 26, 2001 11:05:25 PM +0400 Samium Gromoff
<_deepfire@mail.ru> wrote:

>       Hi People...
>    got a following "dead of alive" question:
>    how to find a root block on a ReiserFS partition
>    with a corrupted superblock?
> 
>    reiserfsprogs-3.x.0.9j simply writes -2^32
>    there at start (reset_super_block) and then simply
>    crashes when attempting to access to such mad place
>           ... got nearly lost my main partition ...
> 
> 

The reiserfsck ---rebuild-tree will find the root block for you.  Now that
you've rebuilt the super, run with --rebuild-tree and it should find
everything.

-chris

