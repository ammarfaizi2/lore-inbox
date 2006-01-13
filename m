Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423030AbWAMWZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWAMWZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbWAMWZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:25:23 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:8465 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1423025AbWAMWZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:25:21 -0500
Date: Fri, 13 Jan 2006 17:25:12 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: wireless: recap of current issues (actions)
Message-ID: <20060113222512.GN16166@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213311.GI16166@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113213311.GI16166@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actions
=======

I need to establish a public git tree for wireless.  I would like for
this to be on kernel.org, but I haven't got an account established
there yet.  I've been dragging my feet a little, hoping that the
kernel.org account would materialize.

I intend to get the sipsolutions softmac code into the wireless
development kernels ASAP.  I hope this will spur driver writers that
need this functionality to start consolidating on the in-kernel stack.

Obviously, what to do with the DeviceScape stack is a pressing issue.
I am open to taking patches to introduce the DeviceScape stack on a
branch under the (still coming) wireless tree.  Obviously, patches
that bring features from the DeviceScape stack to the ieee80211 stack
would be generally welcome.

Since we are toying with the issue of multiple stacks (at least in the
wireless development kernels), some thought needs to be done w.r.t. how
to make a final decision between the two stacks.  An objective lists
of functional feature requirements seems like a good place to start.
IOW, I would like to have a list of features that would trigger the
removal of one stack shortly after the other stack achieves support
for the list.  Is this feasible?
-- 
John W. Linville
linville@tuxdriver.com
