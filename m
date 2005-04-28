Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVD1OhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVD1OhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVD1OhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:37:03 -0400
Received: from gate.in-addr.de ([212.8.193.158]:53216 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261818AbVD1Og7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:36:59 -0400
Date: Thu, 28 Apr 2005 16:36:19 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: David Teigland <teigland@redhat.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050428143619.GZ21645@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050426053930.GA12096@redhat.com> <20050426184845.GA938@ca-server1.us.oracle.com> <20050427132343.GX4431@marowsky-bree.de> <20050427181245.GB938@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050427181245.GB938@ca-server1.us.oracle.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T11:12:45, Mark Fasheh <mark.fasheh@oracle.com> wrote:

> The short answer is no but that we're collecting them. Right now, I can say
> that if you take our whole stack into consideration OCFS2 for things like
> kernel untars and builds (a common test over here), is typically almost as
> fast as ext3 (single node obviously) even when we have a second or third
> node mounted.

Well, agreed that's great, but that seems to imply just generic sane
design: Why should the presence of another node (which does nothing, or
not with overlapping objects on disk) cause any substantial slowdown?

Admittedly we seem to be really short of meaningful benchmarks for DLMs
and/or clustering filesystems...

Hey. Wait. Benchmarks. Scalability issues. No real coding involved.
Anyone from OSDL listening?  ;-)

> As far as specific DLM timings go, we're in the process of collecting them.

Perfect.

> As you know, lately we have been deep in a process of stabilizing things :)

Yes, but this also would be a great time to identify real performance
bugs before shipping - so consider it as part of stress tesing ;-)

> While we have collected timings independent of the FS in the past, we
> haven't done that recently enough that I'd feel comfortable posting it.

Understood.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

