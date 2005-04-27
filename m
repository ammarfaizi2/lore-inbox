Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVD0NwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVD0NwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVD0NwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:52:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30660 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261525AbVD0Nu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:50:58 -0400
Date: Wed, 27 Apr 2005 21:54:28 +0800
From: David Teigland <teigland@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dlm: build
Message-ID: <20050427135428.GF16502@redhat.com>
References: <20050425151333.GH6826@redhat.com> <20050425142525.70e72e93.akpm@osdl.org> <200504260352.j3Q3qGEP010127@turing-police.cc.vt.edu> <20050426055235.GD12096@redhat.com> <20050427132547.GY4431@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427132547.GY4431@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 03:25:47PM +0200, Lars Marowsky-Bree wrote:
> On 2005-04-26T13:52:35, David Teigland <teigland@redhat.com> wrote:
> 
> > Other transports are definately a possibility and something that should be
> > quite simple since it's all encapsulated in lowcomms as you've mentioned.
> 
> That begs the question why you have choosen SCTP for the newer DLM
> versions. Curiousity kills the cat, so I'm asking ;-)

Because it allows you to easily take advantage of multi-homing where a
node has redundant networks.

Dave

