Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbRCAAm7>; Wed, 28 Feb 2001 19:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129424AbRCAAmu>; Wed, 28 Feb 2001 19:42:50 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:50704 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129421AbRCAAmf>; Wed, 28 Feb 2001 19:42:35 -0500
Date: Thu, 1 Mar 2001 01:39:46 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alexander Zarochentcev <zam@namesys.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hans Reiser <reiser@namesys.com>, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2
Message-ID: <20010301013946.X25658@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010228222130.A3131@crimson.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010228222130.A3131@crimson.namesys.com>; from zam@namesys.com on Wed, Feb 28, 2001 at 10:21:30PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 10:21:30PM +0300, Alexander Zarochentcev wrote:
> 6. Using integer constants from limits.h instead of self made ones

That's a userland header file. Don't use it in the kernel.

> 7. other minor fixes.

Does this patch contain Chris Mason's "tail conversion" fix that he
made after my bug report?


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
