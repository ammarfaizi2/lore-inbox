Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWGRUSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWGRUSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGRUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:18:03 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:47328 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932365AbWGRUSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:18:02 -0400
Subject: Re: Bad ext3/nfs DoS bug
From: Marcel Holtmann <marcel@holtmann.org>
To: James <20@madingley.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060718152341.GB27788@circe.esc.cam.ac.uk>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	 <1153209318.26690.1.camel@localhost>
	 <20060718145614.GA27788@circe.esc.cam.ac.uk>
	 <1153236136.10006.5.camel@localhost>
	 <20060718152341.GB27788@circe.esc.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 22:18:26 +0200
Message-Id: <1153253907.21024.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> > What is the reason behind your question? Does disabling subtree checking
> > changes something?
> 
> just that the iget() call which causes the problem in 2.6
> is happening in the subtree checking code, not based on
> analysis of the flow.

just did a quick test with the RHEL4 kernel (2.6.9 based) and
subtree_check and no_subtree_check export option. No difference and in
both cases it gets remounted read-only.

Regards

Marcel


