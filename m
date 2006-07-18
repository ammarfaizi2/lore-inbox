Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWGRPXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWGRPXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWGRPXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:23:45 -0400
Received: from daleth.esc.cam.ac.uk ([131.111.64.59]:21000 "EHLO
	aleph.esc.cam.ac.uk") by vger.kernel.org with ESMTP id S932270AbWGRPXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:23:44 -0400
Date: Tue, 18 Jul 2006 16:23:41 +0100
From: James <20@madingley.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: James <20@madingley.org>, linux-kernel@vger.kernel.org
Subject: Re: Bad ext3/nfs DoS bug
Message-ID: <20060718152341.GB27788@circe.esc.cam.ac.uk>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk> <1153209318.26690.1.camel@localhost> <20060718145614.GA27788@circe.esc.cam.ac.uk> <1153236136.10006.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153236136.10006.5.camel@localhost>
User-Agent: Mutt/1.4.1i
X-Mail-Author: fish
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the reason behind your question? Does disabling subtree checking
> changes something?

just that the iget() call which causes the problem in 2.6
is happening in the subtree checking code, not based on
analysis of the flow.

James.
