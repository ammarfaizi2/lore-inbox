Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUHOPH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUHOPH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUHOPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:07:06 -0400
Received: from kanga.kvack.org ([66.96.29.28]:65203 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S266764AbUHOPFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:05:08 -0400
Date: Sun, 15 Aug 2004 11:04:53 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Lawrence E. Freil" <lef@freil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious Kernel slowdown with HIMEM (4Gig) in 2.6.7
Message-ID: <20040815150453.GA1101@kvack.org>
References: <200408141643.i7EGhCV3003867@dogwood.freil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408141643.i7EGhCV3003867@dogwood.freil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 12:43:11PM -0400, Lawrence E. Freil wrote:
> Though there is a consistant sys component that is slightly higher.  I ran
> profiles three times for "fast" and three times for "slow".  Here they are

Try cat /proc/mtrr.  I bet your system isn't marking some of its RAM 
cachable in the MTRRs.

		-ben
