Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbRFVLo4>; Fri, 22 Jun 2001 07:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265381AbRFVLoq>; Fri, 22 Jun 2001 07:44:46 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:39182 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265380AbRFVLoj>; Fri, 22 Jun 2001 07:44:39 -0400
Date: Fri, 22 Jun 2001 13:43:57 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mktime in include/linux
Message-ID: <20010622134357.D641@arthur.ubicom.tudelft.nl>
In-Reply-To: <200106220230.WAA11443@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106220230.WAA11443@smarty.smart.net>; from humbubba@smarty.smart.net on Thu, Jun 21, 2001 at 10:30:40PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 10:30:40PM -0400, Rick Hohensee wrote:
> Why does Linux have a mktime routine fully coded in linux/time.h that
> conflicts directly with the ANSI C standard library routine of the same
> name? It breaks a couple things against libc5, including gcc 3.0. OK, you
> don't care about libc5. It's still pretty weird. Wierd? Weird.

This has been brought up many times on this list: you are not supposed
to include kernel headers in userland.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
