Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCSUsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUCSUsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:48:14 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:64854 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261161AbUCSUrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:47:48 -0500
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Woodruff, Robert J" <woody@co.intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
	<405B403F.4000702@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 19 Mar 2004 12:47:45 -0800
In-Reply-To: <405B403F.4000702@redhat.com>
Message-ID: <52oeqs4l8u.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Mar 2004 20:47:45.0426 (UTC) FILETIME=[6E6FEF20:01C40DF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ulrich> I think I should be telling something about another nuance
    Ulrich> of this problem.  Parties interested in Infiniband have
    Ulrich> been working under the OpenGroup umbrella for quite some
    Ulrich> time now on API extensions to better accommodate
    Ulrich> interconnect fibers.  They've even presented at am Austin
    Ulrich> Group meeting in 2001 (I think) to get on the road map for
    Ulrich> being included in POSIX.

    Ulrich> But when I wanted to take a look at the specs this was
    Ulrich> categorically rejected.  My contacts were explicitly
    Ulrich> forbidden to give the drafts to anybody but the elite
    Ulrich> circle.  Mind you, Red Hat is member of the OpenGroup.

    Ulrich> So, these people come up with their own software stacks,
    Ulrich> unreviewed interface extensions, and demand that everybody
    Ulrich> accepts what they were "designing" without the ability to
    Ulrich> question anything.

    Ulrich> I surely find this completely unacceptable and any
    Ulrich> consideration of accepting anything the Infiniband group
    Ulrich> comes up with should be postponed until every bit of the
    Ulrich> design can be reviewed.  If bits and pieces are accepted
    Ulrich> prematurely it'll just be "now that this is support you
    Ulrich> have to add this too, otherwise it'll not be useful".

I believe what you are referring to is the OpenGroup's "ITAPI" work.
This is in a sense a competing spec to the DAT Collaborative
(www.datcollaborative.org) work.  The DAT Collaborative seems to be
far more open, and their spec is available without any hurdles.

Any demands from groups designing unacceptable specs should be treated
with the appropriate level of cooperation.

Note that neither the OpenGroup nor the DAT Collaborative are
affiliated with the InfiniBand Trade Association or the OpenIB group,
although they may have members in common.

Best,
  Roland
