Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUIHJX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUIHJX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUIHJX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:23:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269043AbUIHJXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:23:42 -0400
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Tweedie <sct@redhat.com>, Richard A Nelson <cowboy@debian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908020402.3823a658.akpm@osdl.org>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	 <20040908020402.3823a658.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1094635403.1985.12.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Sep 2004 10:23:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2004-09-08 at 10:04, Andrew Morton wrote:

> >   Unable to handle kernel paging request at virtual address 6b6b6b93
> > ...
> >   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
> 
> This might have been caused by a fishy latency-reduction patch.  I today
> dropped that patch so could you please test next -mm and let me know?

That, or preempt.  If the next -mm still breaks, time to hunt for the
preempt problem, I guess.

--Stephen


