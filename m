Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129581AbRBXUUG>; Sat, 24 Feb 2001 15:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbRBXUTz>; Sat, 24 Feb 2001 15:19:55 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:17930 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S129581AbRBXUTp>;
	Sat, 24 Feb 2001 15:19:45 -0500
Date: Sat, 24 Feb 2001 14:18:55 -0600
From: David Fries <dfries@umr.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
Message-ID: <20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
In-Reply-To: <20010214002750.B11906@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010214002750.B11906@unthought.net>; from jakob@unthought.net on Wed, Feb 14, 2001 at 12:27:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have my home directory mounted on one computer from another.  I
rebooted the server and now the client is saying Stale NFS file handle
anytime something goes to read my home directory.  It has been this  
way for about a day.  Shouldn't any caches expire by now?

Both server and client are running 2.4.2.

I'ved tried `mount /home -o remount`, and reading lots of other
directories to flush out that entry if it was in cache without any
results.

I was hopping to avoid unmounting, as I would have to shut about
everything down to do that.

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@umr.edu             |
		+---------------------------------+
