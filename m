Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJGAOo>; Sun, 6 Oct 2002 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbSJGAOo>; Sun, 6 Oct 2002 20:14:44 -0400
Received: from almesberger.net ([63.105.73.239]:11539 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262266AbSJGAOn>; Sun, 6 Oct 2002 20:14:43 -0400
Date: Sun, 6 Oct 2002 21:19:52 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Allan Duncan <allan.d@bigpond.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 etc and IDE HDisk geometry
Message-ID: <20021006211952.C14894@almesberger.net>
References: <3D9D9BE4.32421A87@bigpond.com> <20021004215049.GA20192@win.tue.nl> <3DA0AFBE.935D25BA@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA0AFBE.935D25BA@bigpond.com>; from allan.d@bigpond.com on Mon, Oct 07, 2002 at 07:48:46AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Duncan wrote:
> Like LILO.  It complains that the partition tables don't match the
> geometry, or somesuch, despite an explicit "lba32".

If everything else is fine, and if this is one of the errors from
the partition table checks, you could turn it simply into a
non-fatal warning with the config option "IGNORE-TABLE".

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
