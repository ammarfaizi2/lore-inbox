Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbTBRAsP>; Mon, 17 Feb 2003 19:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTBRAsP>; Mon, 17 Feb 2003 19:48:15 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:62215 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267427AbTBRAsP>; Mon, 17 Feb 2003 19:48:15 -0500
Date: Tue, 18 Feb 2003 00:58:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: owner-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Fix warnings for XFS on 2.5.61
Message-ID: <20030218005811.A3709@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Hemminger <shemminger@osdl.org>, owner-xfs@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs@oss.sgi.com
References: <1045522194.12947.92.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045522194.12947.92.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Mon, Feb 17, 2003 at 02:49:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2003 at 02:49:57PM -0800, Stephen Hemminger wrote:
> This patch gets rid of the following warnings.
> 
> fs/xfs/support/qsort.c: In function `qsort':
> fs/xfs/support/qsort.c:202: warning: duplicate `const'

This is a bug in recent gcc versions, submit a patch to gcc instead.

