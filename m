Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVAUUjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVAUUjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVAUUgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:36:55 -0500
Received: from kanga.kvack.org ([66.96.29.28]:25574 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262511AbVAUUeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:34:20 -0500
Date: Fri, 21 Jan 2005 15:33:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: device-mapper: fix TB stripe data corruption
Message-ID: <20050121203354.GC2265@kvack.org>
References: <20050121181203.GI10195@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121181203.GI10195@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 06:12:03PM +0000, Alasdair G Kergon wrote:
> Missing cast thought to cause data corruption on devices with stripes > ~1TB.

Why not make chunk a sector_t?

		-ben
