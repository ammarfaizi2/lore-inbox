Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTJ1LA2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 06:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbTJ1LAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 06:00:15 -0500
Received: from gate.in-addr.de ([212.8.193.158]:57739 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263928AbTJ1LAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 06:00:08 -0500
Date: Tue, 28 Oct 2003 12:00:34 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Mark Bellon <mbellon@mvista.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031028110034.GG30725@marowsky-bree.de>
References: <3F9D82F0.4000307@mvista.com> <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3F9D8AAA.7010308@mvista.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-10-27T14:14:18,
   Mark Bellon <mbellon@mvista.com> said:

> The uSDE and udev are simlar in some respects. The uSDE allows for 
> complete control of the policy handling a device - not just its naming. 

Well, so could udev in theory, and I had this plan to enhance it to do
so for the specific case of multipathing one day in the not too distant
future (ie, before q1/04).

In as far as I can see, udev and uSDE really do not have too different
goals. Competition is good, but only if they explore distinct approaches
;-)

> >How does this integrate with DM, md, EVMS, LVM...?
> As devices appear in sysfs the uSDE reacts to them via their hotplug 
> events. The policy for each device handles any device issues including 
> dealing with any device nodes.  It is possible to track and maintain 
> multiported devices and automatically provide multipath devices nodes 
> for instance.

Yes, I know that, I was asking whether you had done any discussion with
the EVMS2 folks for example to have a policy plugin to interact with
EVMS2 accordingly and do the magic.



Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

