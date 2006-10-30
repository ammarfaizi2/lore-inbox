Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWJ3LQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWJ3LQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWJ3LQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:16:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22736 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161258AbWJ3LQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:16:13 -0500
Date: Mon, 30 Oct 2006 03:15:31 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030031531.8c671815.pj@sgi.com>
In-Reply-To: <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> I've played around with the idea where the hierarchies of resource
> controller entities was distinct from the hierarchy of process
> containers.

It would be nice, me thinks, if the underlying container technology
didn't really care whether we had one hierarchy or seven.  Let the
users (such as CKRM/RG, cpusets, ...) of this container infrastructure
determine when and where they need separate hierarchies, and when and
where they are better off sharing the same hierarchy.

The question of one or more separate hierarchies is one of those long
term questions that should be driven by the basic semantics of what we
are trying to model, not by transient infrastructure expediencies.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
