Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWCYArf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWCYArf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWCYArf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:47:35 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:24865 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751320AbWCYAre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:47:34 -0500
X-IronPort-AV: i="4.03,127,1141632000"; 
   d="scan'208"; a="1788197316:sNHT33578604"
To: boutcher@cs.umn.edu (Dave C Boutcher)
Cc: Mike Christie <michaelc@cs.wisc.edu>, Jeff Garzik <jeff@garzik.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>, ian.pratt@cl.cam.ac.uk,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
X-Message-Flag: Warning: May contain useful information
References: <A95E2296287EAD4EB592B5DEEFCE0E9D4B9E8A@liverpoolst.ad.cl.cam.ac.uk>
	<4421D943.1090804@garzik.org>
	<1143202673.18986.5.camel@localhost.localdomain>
	<4423E853.1040707@garzik.org> <4423F60B.6020805@garzik.org>
	<1143207657.2882.65.camel@laptopd505.fenrus.org>
	<4423F91F.4060007@garzik.org>
	<17444.4455.240044.724257@hound.rchland.ibm.com>
	<442442CB.4090603@cs.wisc.edu>
	<17444.18012.796603.193315@hound.rchland.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 24 Mar 2006 16:47:26 -0800
In-Reply-To: <17444.18012.796603.193315@hound.rchland.ibm.com> (Dave C. Boutcher's message of "Fri, 24 Mar 2006 13:19:56 -0600")
Message-ID: <adaveu3fizl.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Mar 2006 00:47:32.0700 (UTC) FILETIME=[B389F9C0:01C64FA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> And yeah, I'm aware that there is another SRP implementation
    Dave> in the kernel...Merging would be good...

Changing the ibmvscsi driver to use the include/scsi/srp.h header file
at least is on my list of things to do.  Probably a 2.6.18 type of thing.

 - R.
