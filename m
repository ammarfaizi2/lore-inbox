Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbUJ1Rny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbUJ1Rny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUJ1Rny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:43:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262012AbUJ1Rnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:43:40 -0400
Date: Thu, 28 Oct 2004 13:01:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Ross <chris@tebibyte.org>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       javier@marcet.info, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
Message-ID: <20041028150145.GF5741@logos.cnet>
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet> <41810FD6.9020202@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41810FD6.9020202@tebibyte.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 05:27:18PM +0200, Chris Ross wrote:
> 
> 
> Marcelo Tosatti escreveu:
> >Can you please test Rik's patch with your spurious OOM kill testcase?
> 
> Do you have a particular test case in mind? 

Anonymous memory intensive loads. It was easy to trigger the 
problem with "fillmem" from Quintela's memtest suite.

> Is it accessible to the rest 
> of us? If you send it to me I will run it on my 64MB P2 machine, which 
> makes a very good test rig for the oom_killer because it is normally 
> plagued by it.
> 
> I have already run Rik's patch to great success using my test case of 
> compiling umlsim. Without the patch this fails every time at the linking 
> the UML kernel stage.

Cool!
