Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318497AbSIBWZ7>; Mon, 2 Sep 2002 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318503AbSIBWZ7>; Mon, 2 Sep 2002 18:25:59 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:63992 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318497AbSIBWZ6>; Mon, 2 Sep 2002 18:25:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 2 Sep 2002 16:28:37 -0600
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid anti-spam testings...
Message-ID: <20020902222837.GM32468@clusterfs.com>
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <20020902215019.GB5834@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020902215019.GB5834@mea-ext.zmailer.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03, 2002  00:50 +0300, Matti Aarnio wrote:
> Quite a many of vger's recipients are doing return-path verification
> testing for SMTP's MAIL FROM address.
> 
> I would not mind that, EXCEPT that those bloody stupid things don't
> have any sane caches at all!    VGER is sending 300+ messages per
> day to 3500+ recipients of linux-kernel list EVERY DAY, and every
> outgoing message is now getting oodles of those probes!
> 
> Folks,  when you deploy that kind of testers, DO VERIFY THAT THEY
> HAVE SANE CACHES!  A positive result shall be cached for at least
> two hours, a negative result shall be cached for at least 30 minutes.

Do you know if this is one of the default checks from spamassassin?
I would imagine that a lot of people (including myself) have it
installed, so it is possible that it (or some other widely-used tool)
now does this sort of check out-of-the-box, and the people who are
installing them have no idea about the kind of load it generates on vger.
I doubt that there are a large number of people who are independently
misconfiguring their mail setup this way

If it is possible to track what tool is causing the problem and fixing
the default setup of that tool at the source, it will probably solve
99% of the problems in one go (after the list knows to which version
they should upgrade).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

