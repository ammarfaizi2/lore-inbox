Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbSKUScQ>; Thu, 21 Nov 2002 13:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266943AbSKUScQ>; Thu, 21 Nov 2002 13:32:16 -0500
Received: from borg.org ([208.218.135.231]:40633 "HELO borg.org")
	by vger.kernel.org with SMTP id <S266940AbSKUScO>;
	Thu, 21 Nov 2002 13:32:14 -0500
Date: Thu, 21 Nov 2002 13:39:22 -0500
From: Kent Borg <kentborg@borg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Message-ID: <20021121133922.M16336@borg.org>
References: <20021121125240.K16336@borg.org> <3DDD24E7.4040603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DDD24E7.4040603@pobox.com>; from jgarzik@pobox.com on Thu, Nov 21, 2002 at 01:24:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 01:24:39PM -0500, Jeff Garzik wrote:
> man shred(1)
> 
> Much better than anything implemented in-kernel

Yes, but that will only apply to files that I specifically shred.  I
hazard that a lot more files than the ones I explicitly "rm" in a day
get deleted by other means.  Also, the shred man page even says that
it doesn't know if its "shredding" even happens in the same spot on
disk as the original data resided.  It seems this has to happen down
in the file system if there is any hope of it working.  And even there
it could use come help from the disk drive to make sure things can be
made to happen where they appear to happen.


-kb
