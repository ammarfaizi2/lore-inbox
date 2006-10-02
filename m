Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWJBIqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWJBIqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWJBIqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:46:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57808 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932318AbWJBIqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:46:20 -0400
Date: Mon, 2 Oct 2006 01:46:04 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, dev@sw.ru, mbligh@google.com,
       winget@google.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 1/4] Generic container system
 abstracted from cpusets code
Message-Id: <20061002014604.9b43cc24.pj@sgi.com>
In-Reply-To: <6599ad830610012348p1059f424ua48b62dd30a6c3fd@mail.gmail.com>
References: <20060928104035.840699000@menage.corp.google.com>
	<20060928111407.762783000@menage.corp.google.com>
	<20060928164536.84039937.pj@sgi.com>
	<6599ad830610012348p1059f424ua48b62dd30a6c3fd@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> Anyone have any thoughts on the usefulness/insanity of such an idea?

[multiple hierarchies]  I'd say let's pretend we don't know how to
do them, until we have good reason otherwise.  Having just a single
resource hierarchy simplifies the thinking of these things.  If doing
so fits 90% of the needs, and can be stretched to get most of the
remaining needs, then that simplification is well worth it.  It might
mean that a reasonable number of people can actually understand this
stuff, which is always a nice property.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
