Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265017AbUELFtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265017AbUELFtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUELFtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:49:10 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:12049 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264989AbUELFse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:48:34 -0400
Date: Wed, 12 May 2004 06:48:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040512064831.B25250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Porter <mporter@kernel.crashing.org>, akpm@osdl.org,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org
References: <20040511170150.A4743@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040511170150.A4743@home.com>; from mporter@kernel.crashing.org on Tue, May 11, 2004 at 05:01:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 05:01:50PM -0700, Matt Porter wrote:
> New OCP infrastructure ported from 2.4 along with several
> enhancements. Please apply.

The old-style PM callback (using struct pm_dev) is bogus, please kill
that part.

