Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVAPQCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVAPQCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVAPQCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 11:02:16 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:38022 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261546AbVAPQCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 11:02:14 -0500
Date: Sun, 16 Jan 2005 11:02:13 -0500
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050116160213.GB13624@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:18:51PM +0000, Al Viro wrote:
> 	6. mount --move
> prohibited if what we are moving is in some p-node, otherwise we move
> as usual to intended mountpoint and create copies for everything that
> gets propagation from there (as we would do for rbind).

Why this prohibition?

--Bruce Fields
