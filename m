Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWBXQbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWBXQbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWBXQbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:31:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19330 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932371AbWBXQbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:31:14 -0500
Date: Fri, 24 Feb 2006 16:31:04 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: device-mapper development <dm-devel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm missing bdput/thaw_bdev at removal
Message-ID: <20060224163104.GP31641@agk.surrey.redhat.com>
Mail-Followup-To: device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <43FE4DB5.5050904@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE4DB5.5050904@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 07:05:09PM -0500, Jun'ichi Nomura wrote:
> Then dm_suspend will try to freeze_bdev and wait forever.
 
> Attached patch fixes this problem.

Indeed - well spotted!

Alasdair
-- 
agk@redhat.com
