Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276963AbRJCUIw>; Wed, 3 Oct 2001 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276964AbRJCUIm>; Wed, 3 Oct 2001 16:08:42 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:15370 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S276963AbRJCUIZ>; Wed, 3 Oct 2001 16:08:25 -0400
Date: Wed, 3 Oct 2001 22:08:51 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Christian Schroeder <c-h.schroeder@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Kernel 2.4.10 on SMP
Message-ID: <20011003220850.H3638@arthur.ubicom.tudelft.nl>
In-Reply-To: <20011003145729Z276343-760+20191@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011003145729Z276343-760+20191@vger.kernel.org>; from c-h.schroeder@gmx.net on Wed, Oct 03, 2001 at 04:56:51PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 04:56:51PM +0200, Christian Schroeder wrote:
> since I've been experisnsing large problems with my linux box crashing and 
> crashing again, I want to give you this bug report, maybe someone else has 
> the same problem. I used the bug report format in explained in the kernel 
> sources.

[...]

> [7.3]
> snd-pcm-oss            18816   1 (autoclean)
> snd-pcm-plugin         14256   0 (autoclean) [snd-pcm-oss]
> snd-mixer-oss           5280   0 (autoclean) [snd-pcm-oss]
> NVdriver              723872  14 (autoclean)
  ^^^^^^^^
You have the NVidia binary only module loaded on your system. Either
get support from NVidia, or try to recreate the bug without this
module.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
