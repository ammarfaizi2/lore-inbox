Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVHKIlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVHKIlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVHKIlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:41:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35039 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030224AbVHKIlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:41:20 -0400
Date: Thu, 11 Aug 2005 16:46:45 +0800
From: David Teigland <teigland@redhat.com>
To: Michael <mikore.li@gmail.com>, linux-cluster@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: GFS - updated patches
Message-ID: <20050811084645.GD12438@redhat.com>
References: <20050802071828.GA11217@redhat.com> <20050811081729.GB12438@redhat.com> <bc57270905081101217fdd4c5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc57270905081101217fdd4c5f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 04:21:04PM +0800, Michael wrote:
> I have the same question as I asked before, how can I see GFS in "make
> menuconfig", after I patch gfs2-full.patch into a 2.6.12.2 kernel?

You need to select the dlm under drivers.  It's in -mm, or apply
  http://redhat.com/~teigland/dlm.patch

