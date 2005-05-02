Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVEBMiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVEBMiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVEBMiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:38:21 -0400
Received: from gate.in-addr.de ([212.8.193.158]:26566 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261200AbVEBMiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:38:18 -0400
Date: Mon, 2 May 2005 13:21:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Lang <dlang@digitalinsight.com>, "Theodore Ts'o" <tytso@mit.edu>
Cc: Daniel Phillips <phillips@istop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050502112147.GP4722@marowsky-bree.de>
References: <20050425151136.GA6826@redhat.com> <20050428145715.GA21645@marowsky-bree.de> <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz> <200504282152.31137.phillips@istop.com> <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz> <20050501035746.GA6578@thunk.org> <Pine.LNX.4.62.0504302110530.9153@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0504302110530.9153@qynat.qvtvafvgr.pbz>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-30T21:14:45, David Lang <dlang@digitalinsight.com> wrote:

> I will say that this wasn't what I thought we was being talked about for 
> cluster membership, becouse I assumed that the generation of an ID would 
> be repeatable so that a cluster node could be rebuilt and re-join the 
> cluster with it's old ID.

Hm? Every node generates its UUID _once_ and stores it on persistent
local storage. It doesn't get regenerated.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

