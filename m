Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWJ3OaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWJ3OaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJ3OaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:30:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750706AbWJ3OaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:30:04 -0500
Date: Mon, 30 Oct 2006 06:29:44 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030062944.c5f73661.pj@sgi.com>
In-Reply-To: <454609DE.9060901@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	<20061030024320.962b4a88.pj@sgi.com>
	<454609DE.9060901@openvz.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel wrote:
> My point is that a good infrastrucure doesn't care wether
> or not beancounter (group controller) has a parent.

I am far more interested in the API, including the shape
of the data model, that we present to the user across the
kernel-user boundary.

Getting one, good, stable API for the long haul is worth alot.

Whether or not some substantial semantic change in this, such
as going from a flat to a tree shape, can be done in a single
line of kernel code, or a thousand lines, is less important.

What is the right long term kernel-user API and data model?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
