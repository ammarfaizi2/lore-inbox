Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVIAJ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVIAJ6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVIAJ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:58:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53979 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932074AbVIAJ6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:58:44 -0400
Date: Thu, 1 Sep 2005 02:58:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: akpm@osdl.org, mel@csn.ul.ie, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, jschopp@austin.ibm.com, Simon.Derr@bull.net,
       torvalds@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH 1/4] cpusets oom_kill tweaks
Message-Id: <20050901025827.0e620dd9.pj@sgi.com>
In-Reply-To: <2cd57c900509010239670c07a2@mail.gmail.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
	<20050901090859.18441.67380.sendpatchset@jackhammer.engr.sgi.com>
	<2cd57c900509010239670c07a2@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf wrote:
> Why bother ...

The line length in characters was getting too long, the logic was
getting too convoluted, and the comment only applied to an unobvious
portion of the line.

Providing a name for the logical condition that a complicated
expression computes is one of the ways I find useful to make
code easier to read, and to resolve problems such as those above.

My primary goal in writing code is to minimize the time and effort
it will take a typical reader to properly understand the code.
I write first and foremost for humans.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
