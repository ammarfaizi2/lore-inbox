Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422629AbWJ3Ulm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422629AbWJ3Ulm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWJ3Ulm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:41:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6799 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030565AbWJ3Ulk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:41:40 -0500
Date: Mon, 30 Oct 2006 12:41:02 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dmccr@us.ibm.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       devel@openvz.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030124102.f8957d06.pj@sgi.com>
In-Reply-To: <6599ad830610301007n2c974199m407f3818dd77365a@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<20061030024320.962b4a88.pj@sgi.com>
	<20061030170916.GA9588@in.ibm.com>
	<200610301116.04780.dmccr@us.ibm.com>
	<6599ad830610301007n2c974199m407f3818dd77365a@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I believe that
> there are people out there who depend on them (right, PaulJ?)

Yes.  For example a common usage pattern has the system admin carve
off a big chunk of CPUs and Memory Nodes into a cpuset for the batch
scheduler to manage, within which the batch scheduler creates child
cpusets, roughly one for each job under its control.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
