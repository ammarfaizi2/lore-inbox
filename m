Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTJKN1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 09:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJKN1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 09:27:04 -0400
Received: from gate.in-addr.de ([212.8.193.158]:64656 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263303AbTJKN1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 09:27:01 -0400
Date: Sat, 11 Oct 2003 15:24:22 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031011132422.GI1084@marowsky-bree.de>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <200310100830.03216.kevcorry@us.ibm.com> <20031010182918.GF1084@marowsky-bree.de> <20031011034951.GE4716@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031011034951.GE4716@pegasys.ws>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-10-10T20:49:51,
   jw schultz <jw@pegasys.ws> said:

> I concur with one caviat.  0+1 has the advantage of
> extendability that doesn't exist with 1+0.

Right, this annoying complicated approach you describe can be done much
easier with 1+0. With [EL]VMS?[12] you can simply create a new raid1 set
and add it as a physical volume to the volume group and then extend the
LVs accordingly. (I am unsure whether you can add a new disk to a raid0
set if you don't want to use a volume manager, but if it's not
currently, it sounds fairly straightforward to add.)

Your approach with breaking the mirrors etc includes prolonged periods
of no redundancy and makes me shiver.

There's some *buy it* good book about *buy it* all this, but if I go
hype *buy it* "Blueprints for High Availability" *buy it* one more time,
people are going to accuse me of *buy this book already!* of flogging a
dead horse *buy it*, so for this time, I am going to recommend reading
some linux LVM and RAID howtos ;-)

So, I think, as far as RAID and Volume Management is concerned, Linux
does pretty well. There's some advanced and fancy stuff missing (>2
mirrors, online consistency check, etc), but the basics are pretty well
done.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SUSE LINUX AG		-- Samuel Beckett

