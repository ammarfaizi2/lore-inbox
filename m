Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbSJDNxO>; Fri, 4 Oct 2002 09:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSJDNxO>; Fri, 4 Oct 2002 09:53:14 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35346 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261747AbSJDNxN>; Fri, 4 Oct 2002 09:53:13 -0400
Date: Fri, 4 Oct 2002 14:58:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004145845.A30064@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	kernel <linux-kernel@vger.kernel.org>
References: <20021003153943.E22418@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003153943.E22418@openss7.org>; from bidulock@openss7.org on Thu, Oct 03, 2002 at 03:39:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:39:43PM -0600, Brian F. G. Bidulock wrote:
> I see that RH, in their infinite wisdom, have seen fit to remove
> the export of sys_call_table in 8.0 kernels breaking any loadable
> modules that wish to implement non-implemented system calls such
> as LiS's or iBCS implementation of putmsg/getmsg.

There is no such thing as iBCS for 2.4+.  iBCS/Linux-ABI are for foreign
personalities only anyway and don't need to touch sys_call_table.

