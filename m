Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbUKPQ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUKPQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKPQ26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:28:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64232 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262034AbUKPQ2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:28:47 -0500
Date: Tue, 16 Nov 2004 16:28:09 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 dm.c dm_init unresolved reference to _exits
Message-ID: <20041116162809.GA24233@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
References: <27983.1100493381@kao2.melbourne.sgi.com> <20041115112323.GI9939@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115112323.GI9939@apps.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 12:23:23PM +0100, Andries Brouwer wrote:
> Yes - thanks for reminding - thought of that yesterday night
> but forgot again the next morning.
 
Also, because one ordered list has been replaced by two, please add a 
comment to warn anyone editing either list of functions that the two ordered 
lists must correspond: every function in _inits must have an exit function
in the corresponding position in _exits.

The macro looked pretty horrid, but did you consider just expanding it out?

Alasdair

