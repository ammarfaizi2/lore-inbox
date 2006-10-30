Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWJ3PUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWJ3PUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWJ3PUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:20:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59361 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030426AbWJ3PT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:19:59 -0500
Date: Mon, 30 Oct 2006 07:18:38 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: xemul@openvz.org, vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       menage@google.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030071838.7988d3e1.pj@sgi.com>
In-Reply-To: <45460E69.7070505@openvz.org>
References: <20061030103356.GA16833@in.ibm.com>
	<45460743.8000501@openvz.org>
	<20061030062332.856dcc32.pj@sgi.com>
	<45460E69.7070505@openvz.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel wrote:
> >> 3. Configfs may be easily implemented later as an additional
> >>    interface. I propose the following solution:
> >>      ...
> >
> Resource controller has nothing common with confgifs.
> That's the same as if we make netfilter depend on procfs.

Well ... if you used configfs as an interface to resource
controllers, as you said was easily done, then they would
have something to do with each other, right ;)?

Choose the right data structure for the job, and then reuse
what fits for that choice.

Neither avoid nor encouraging code reuse is the key question.

What's the best fit, long term, for the style of kernel-user
API, for this use?  That's the key question.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
