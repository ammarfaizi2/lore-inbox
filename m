Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUFBVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUFBVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUFBVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:15:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63616 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264188AbUFBVPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:15:52 -0400
Date: Wed, 2 Jun 2004 22:15:44 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-ID: <20040602211544.GT6302@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040602161541.GB15785@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602161541.GB15785@schnapps.adilger.int>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 10:15:41AM -0600, Andreas Dilger wrote:
> It might be nice to have a brief comment here explaining what this is
> and how it is supposed to be used.

  A daemon for copying regions of block devices around in an efficient
  manner.  Multiple destinations can be specified for a copy.
  Designed to perform well both with many small chunks or few large chunks.

Alasdair
-- 
agk@redhat.com
