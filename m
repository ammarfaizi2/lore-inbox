Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbREaRXE>; Thu, 31 May 2001 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263120AbREaRWz>; Thu, 31 May 2001 13:22:55 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:17417 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262445AbREaRWo>;
	Thu, 31 May 2001 13:22:44 -0400
Date: Thu, 31 May 2001 13:24:54 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Cc: torvalds@transmeta.com, laughing@shared-source.org
Subject: Configure.help is complete
Message-ID: <20010531132454.A8361@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com,
	laughing@shared-source.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It gives me great pleasure to announce that the Configure.help master
file is now complete with respect to 2.4.5.  Every single one of the
2699 configuration symbols actually used in the 2.4.5 codebase's C
source files or Makefiles now has an entry in Configure.help.

This does not, of course, mean the job of maintaining Configure.help
is done; symbols will be added and dropped in the future (there are a
handful of new ones in ac5, all now documented), and some existing
entries could stand to be rewritten and expanded.  But we have passed
a milestone -- maintainance will now be a matter of keeping the boat
bailed rather than trying to ignore a hole in the side. 

Thanks to all the contributors who helped put together the over 550 
entries necessary to catch up, too many to name here.  The result
is available at:

	http://www.tuxedo.org/~esr/cml2/Configure.help.gz

Though carried on the CML2 project page, it can be used with CML1 and
is current with respect to both Linus's tree and Alan's.

I now have two requests of Linus and Alan:

1. Please pick up this work now.  It is a really substantial improvement
   on what you have in your trees, incorporating it cannot break anything,
   and you'll help prevent unnecessary hassles due to clashing patches
   in the future.

2. Please make a policy of rejecting patches that add new configuration 
   symbols without also adding an explanatory Configure.help entry --
   and please *announce* that you will do so.  We can raise our standards
   now, and for the sake of having a well-documentated kernel and
   configuration system I submit that we ought to.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
