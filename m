Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVDZFtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVDZFtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDZFtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:49:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41856 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261332AbVDZFsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:48:53 -0400
Date: Tue, 26 Apr 2005 13:52:35 +0800
From: David Teigland <teigland@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dlm: build
Message-ID: <20050426055235.GD12096@redhat.com>
References: <20050425151333.GH6826@redhat.com> <20050425142525.70e72e93.akpm@osdl.org> <200504260352.j3Q3qGEP010127@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504260352.j3Q3qGEP010127@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:52:15PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 25 Apr 2005 14:25:25 PDT, Andrew Morton said:
> > David Teigland <teigland@redhat.com> wrote:
> > >
> > >  +config DLM 
> 
> > Shouldn't it enable SCTP?  Depend on NET?
> 
> Looks like it.  As a related question, is the SCTP dependency something
> fairly innate to the design, or would layering it over other low-level
> transports in the future be a possibility? A first glance makes it look
> like only lowcomms.c and maybe midcomms.c would be affected.

Thanks, the suggestions so far have been very good and we're working on
them.

Other transports are definately a possibility and something that should be
quite simple since it's all encapsulated in lowcomms as you've mentioned.

Dave

