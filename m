Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUIIVdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUIIVdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUIIVbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:31:05 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:12799 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S267999AbUIIV0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:26:11 -0400
Date: Thu, 9 Sep 2004 23:25:07 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909212507.GA32276@k3.hellgate.ch>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909205531.GA17088@k3.hellgate.ch>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 22:55:31 +0200, Roger Luethi wrote:
> I used a somewhat different approach in my development tree (not
> SELinuxy, though): Most fields were world readable, some required
> credentials.

I forgot to mention that you can see the remnants of that approach in
<linux/nproc.h>: I used two bits of the field ID to define per-field
access restrictions (NPROC_PERM_USER, NPROC_PERM_ROOT).

Roger
