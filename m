Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266305AbUHMRv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUHMRv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHMRtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:49:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266534AbUHMRsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:48:23 -0400
Date: Fri, 13 Aug 2004 13:26:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Nikolay <Nikolay@Alexandrov.ws>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.27 fs/open.c code small cleanup
Message-ID: <20040813162642.GC29292@logos.cnet>
References: <S268953AbUHMCzp/20040813025546Z+1005@vger.kernel.org> <20040813050239.GB1456@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813050239.GB1456@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 07:02:40AM +0200, Willy Tarreau wrote:
> Hi,
> 
> On Fri, Aug 13, 2004 at 05:49:40AM -0000, Nikolay wrote:
> > A little clean up, soon I'll send few bug fixes and cleanups.
> 
> I don't know for others, but I find it preferable not to change these
> core files for such trivial cleanups. It will not change the output code
> nor will make the source much more readable, but may break some external
> useful patches. There are patches such as vserver and grsecurity which
> touch open.c, and there are certainly others.

Agreed.
