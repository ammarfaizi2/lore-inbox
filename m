Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288006AbSAQAId>; Wed, 16 Jan 2002 19:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288007AbSAQAIX>; Wed, 16 Jan 2002 19:08:23 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:57099 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288006AbSAQAIK>; Wed, 16 Jan 2002 19:08:10 -0500
Date: Thu, 17 Jan 2002 01:07:58 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Rik spreading bullshit about VM
Message-ID: <20020117000758.GL10175@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020116200459.E835@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116200459.E835@athlon.random>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 08:04:59PM +0100, Andrea Arcangeli wrote:
> I read here:
> 
> 	http://linux.html.it/articoli/rik_van_riel_ita1.htm

  [...]

> This is total bullshit. If there's something where the -aa VM is good
> are the DBMS, that was designed for it basically, very lightweight,
> basically no VM overhead also under very heavy I/O.

Sorry, but in my opinion Rik's rmap VM still beats your VM under IO
load. My benchmark is very simple: import a kernel tree into a CVS tree
that already contains about 470 other kernel trees. Both the import
directory and the CVS root are on the same disk. With 2.4.17 the mp3
player stutters, I can't even read email or edit a couple of files with
XEmacs at the same time. With 2.4.17-rmap-11a the mp3 player runs
smoothly and email and XEmacs are usable again.

Some time ago Linus made the important observation that we shouldn't
tune the scheduler for SMP systems simply because 99.9% of the systems
in the world running linux have a single CPU. IMHO an equally well
observation would be that we shouldn't tune the VM for the 0.1% of the
systems in this world that run large DMBSes. The 99.9% majority is much
more important.

Just my 0.02.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
