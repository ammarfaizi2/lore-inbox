Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161235AbWJ3Knt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbWJ3Knt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 05:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWJ3Knt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 05:43:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51677 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161235AbWJ3Knt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 05:43:49 -0500
Date: Mon, 30 Oct 2006 02:43:20 -0800
From: Paul Jackson <pj@sgi.com>
To: vatsa@in.ibm.com
Cc: dev@openvz.org, sekharan@us.ibm.com, menage@google.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, rohitseth@google.com,
       balbir@in.ibm.com, dipankar@in.ibm.com, matthltc@us.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030024320.962b4a88.pj@sgi.com>
In-Reply-To: <20061030103356.GA16833@in.ibm.com>
References: <20061030103356.GA16833@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vatsa wrote:
> C. Paul Menage's container patches
> 
> 	Provides a generic heirarchial ...
> 
> Consensus/Debated Points
> ------------------------
> 
> Consensus:
> 	...
> 	- Dont support heirarchy for now

Looks like this item can be dropped from the concensus ... ;).

I for one would recommend getting the hierarchy right from the
beginning.

Though I can appreciate that others were trying to "keep it simple"
and postpone dealing with such complications.  I don't agree.

Such stuff as this deeply affects all that sits on it.  Get the
basic data shape presented by the kernel-user API right up front.
The rest will follow, much easier.

Good review of the choices - thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
