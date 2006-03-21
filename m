Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWCUSvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWCUSvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWCUSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:51:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:393 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932401AbWCUSvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:51:38 -0500
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060321061333.27638.63963.stgit@localhost.localdomain>
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:50:11 -0800
Message-Id: <1142967011.10906.185.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:13 +1200, Sam Vilain wrote:
> Here is a work in progress of trying to extract some the core vserver
> architecture and present it as an incremental set of patches.

Hi Sam,

These patches are certainly getting better and better broken out all the
time.  Nice work.

But, I worry that they just aren't generic enough yet.  I don't see any
response from any of the other "container/namespace/vps" people.  I fear
that this means that they don't look broadly useful enough, yet.

That said, at this point, I'd just about rather have _anything_ merged
than the nothing we have at this point.  As we throw patches back and
forth, we can't seem to agree on even some very small points.  

I also have a sinking feeling that everybody has gone back off and
continues to develop their own out-of-tree functionality, deepening the
patch divide.

Is there anything we could merge that we _all_ don't like?  I'm pretty
convinced that no single solution will support Eric's, OpenVZ's, and
VServer's _existing_ usage models.  Somebody is going to have to bend,
or nothing will ever get merged.  Any volunteers? ;)

What about going back to the very simple "struct container" on which to
build?

	http://lkml.org/lkml/2006/2/3/205

-- Dave

