Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVE3UMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVE3UMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVE3UMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:12:25 -0400
Received: from kanga.kvack.org ([66.96.29.28]:33439 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261737AbVE3UMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:12:15 -0400
Date: Mon, 30 May 2005 16:14:19 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Message-ID: <20050530201419.GB10212@kvack.org>
References: <20050530181626.GA10212@kvack.org> <20050530193823.GD25794@muc.de> <429B7208.6070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B7208.6070804@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:05:28PM +0200, Michael Thonke wrote:
> No it doesn't like this sample here at all,I'll get segmentationfault on
> that run.

Grab a new copy -- one of the routines had an unaligned store instead of 
aligned for the register save.

		-ben
