Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTJJScF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTJJScF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:32:05 -0400
Received: from gate.in-addr.de ([212.8.193.158]:33769 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262695AbTJJScC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:32:02 -0400
Date: Fri, 10 Oct 2003 20:29:18 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Kevin Corry <kevcorry@us.ibm.com>,
       Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010182918.GF1084@marowsky-bree.de>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <200310100830.03216.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310100830.03216.kevcorry@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-10-10T08:30:03,
   Kevin Corry <kevcorry@us.ibm.com> said:

> On Friday 10 October 2003 01:19, Stuart Longland wrote:
> > 	- Software RAID 0+1 perhaps?

Because RAID 0+1 is a rather bad idea. You want RAID 1+0. Make up the
fault matrix and simulate what happens if drives fail.

We can do both though, as Kevin pointed out. So if you want to shot
yourself in the foot, in the best Unix tradition, we allow you to ;)

I'd suggest moving this to the linux-raid list though.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SUSE LINUX AG		-- Samuel Beckett

