Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUELNlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUELNlR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUELNkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:40:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31926 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S265087AbUELNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:39:42 -0400
Date: Wed, 12 May 2004 06:39:32 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040512063931.E8797@home.com>
References: <20040511170150.A4743@home.com> <000001c437e8$7de0a070$d100000a@sbs2003.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c437e8$7de0a070$d100000a@sbs2003.local>; from hch@infradead.org on Wed, May 12, 2004 at 07:15:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 07:15:15AM +0100, Christoph Hellwig wrote:
> 
> On Tue, May 11, 2004 at 05:01:50PM -0700, Matt Porter wrote:
> > New OCP infrastructure ported from 2.4 along with several
> > enhancements. Please apply.
> 
> The old-style PM callback (using struct pm_dev) is bogus, please kill
> that part.

Thanks. I killed off the deprecated PM stuff in the updated patch
I just sent out.

-Matt
