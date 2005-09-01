Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVIAKtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVIAKtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVIAKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:49:20 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:17740 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964872AbVIAKtU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:49:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ED7v4XXlwl6LTIdZIFuFO6Ae/svhzceRo8O6YhqDGkuskqiPYWvhdOVXIzg6/VRrIRmQDFQE3qgfmjhMXb6B4DkY5TB8npMaIont3wYD4wiOHsr4Sd9d85Jst0+6D3N03QZlfolY5tL9h0MwZNepdZX1hhNS/oroURVfXfDcBPM=
Message-ID: <2cd57c900509010349d2477b1@mail.gmail.com>
Date: Thu, 1 Sep 2005 18:49:11 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 1/4] cpusets oom_kill tweaks
Cc: akpm@osdl.org, mel@csn.ul.ie, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, jschopp@austin.ibm.com, Simon.Derr@bull.net,
       torvalds@osdl.org, haveblue@us.ibm.com
In-Reply-To: <20050901025827.0e620dd9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
	 <20050901090859.18441.67380.sendpatchset@jackhammer.engr.sgi.com>
	 <2cd57c900509010239670c07a2@mail.gmail.com>
	 <20050901025827.0e620dd9.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Paul Jackson <pj@sgi.com> wrote:
> Coywolf wrote:
> > Why bother ...
> 
> The line length in characters was getting too long, the logic was

Yeah.  That long line bugged me too when I was writing my lca oom-killer patch.

> getting too convoluted, and the comment only applied to an unobvious
> portion of the line.
> 
> Providing a name for the logical condition that a complicated
> expression computes is one of the ways I find useful to make
> code easier to read, and to resolve problems such as those above.

Maybe. 

> 
> My primary goal in writing code is to minimize the time and effort
> it will take a typical reader to properly understand the code.
> I write first and foremost for humans.

Hmm, I really wish xfs guys follow that too.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
