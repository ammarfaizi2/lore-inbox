Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWDUQYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWDUQYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWDUQYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:24:38 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:17359 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932419AbWDUQYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:24:37 -0400
Subject: RE: [Disec-devel] Re: [ANNOUNCE] Release Digsig 1.5: kernel module
	for run-time authentication of binaries
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Axelle Apvrille <axelle_apvrille@yahoo.fr>
Cc: Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyn <serue@us.ibm.com>,
       "'disec-devel@lists.sourceforge.net'" 
	<disec-devel@lists.sourceforge.net>
In-Reply-To: <20060421161351.25858.qmail@web26109.mail.ukl.yahoo.com>
References: <20060421161351.25858.qmail@web26109.mail.ukl.yahoo.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 21 Apr 2006 12:29:16 -0400
Message-Id: <1145636956.21749.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 18:13 +0200, Axelle Apvrille wrote:
> > That URL doesn't seem to be working at present.
> 
> Probably a temporary outage ? anyway, it's working
> now...
> 
> http://sourceforge.net/projects/disec/
> or http://disec.sourceforge.net/
> 
> both work.

Yes, seems to be up now.  But you do need to submit your module if you
want to make a case that LSM should be retained in mainline.  Even if
LSM stays, it could be altered in the future to help counter misuse of
the interface, and such changes could break your module if you aren't in
the tree.  Not to mention that out-of-tree modules don't fair well in
general.

-- 
Stephen Smalley
National Security Agency

