Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRBXI3p>; Sat, 24 Feb 2001 03:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBXI3e>; Sat, 24 Feb 2001 03:29:34 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:6369 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129434AbRBXI3O>;
	Sat, 24 Feb 2001 03:29:14 -0500
From: thunder7@xs4all.nl
Date: Sat, 24 Feb 2001 09:18:51 +0100
To: linux-kernel@vger.kernel.org
Cc: mason@suse.com
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <20010224091851.A6610@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny> <20010223231949.D24959@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010223231949.D24959@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Fri, Feb 23, 2001 at 11:19:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2001 at 11:19:49PM +0100, Erik Mouw wrote:
> I got them immediately at the first run, which more or less was what I
> expected because reiserfs ate one of my mailfolders that way (only a
> CVS log folder, so nothing special was lost). You have to remove the
> files between runs, otherwise the same blocks seem to be allocated to
> the files.
> 
> I'll upgrade to linux-2.4.2 to see if it solves the problem. (was
> running 2.4.2-pre4 + your patch)
> 
kernel 2.4.2-ac3, gcc-2.95.2, libc-2.1.3, SuSE-7.0 base system.
Using ReiserFS 3.5.x disk format, binutils-2.10, x86(P3/866)-SMP system.
The program from Erik did the following:

Creating 8192 files ... done
Appending to the files ... done
Checking files for null bytes ...
  reiser-00000.test contains null bytes
  reiser-00001.test contains null bytes
  reiser-00002.test contains null bytes
  reiser-00003.test contains null bytes
  reiser-00004.test contains null bytes
<snip a lot of lines>
  reiser-08189.test contains null bytes
  reiser-08190.test contains null bytes
  reiser-08191.test contains null bytes
Checking done

Good luck,
Jurriaan
-- 
Backup Not Found (A)ssasinate Bill Gates (R)etry (K)eep trying until 6 am?
GNU/Linux 2.4.2-ac3 SMP/ReiserFS 2x1730 bogomips load av: 0.08 0.02 0.01
