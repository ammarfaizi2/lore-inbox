Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRDIOJU>; Mon, 9 Apr 2001 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRDIOJK>; Mon, 9 Apr 2001 10:09:10 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:53764
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S132756AbRDIOIy>; Mon, 9 Apr 2001 10:08:54 -0400
Date: Mon, 09 Apr 2001 09:08:59 -0500
From: Chris Mason <mason@suse.com>
To: xOr <xor@x-o-r.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel oops in reiserfs under 2.4.2-ac28 and 2.4.3-ac3
 when rming files
Message-ID: <204760000.986825339@tiny>
In-Reply-To: <01040815431900.00242@rogue>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, April 08, 2001 03:43:19 PM -0500 xOr <xor@x-o-r.net> wrote:

> [1.] kernel oops in reiserfs under 2.4.2-ac28 and 2.4.3-ac3 when rming
> files 

Ok, reiserfs must be picking the wrong member in an array of function
pointers, probably on a bad item from disk.  We're testing some code from
Alexander Zarochentcev that tries to detect this kind of thing, I'll
forward it to you off list.
 
thanks,
Chris

