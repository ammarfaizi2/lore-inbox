Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTE0OPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTE0OPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:15:44 -0400
Received: from holomorphy.com ([66.224.33.161]:36067 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263624AbTE0OPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:15:43 -0400
Date: Tue, 27 May 2003 07:28:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, manish <manish@storadinc.com>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527142824.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	manish <manish@storadinc.com>, linux-kernel@vger.kernel.org,
	Christian Klose <christian.klose@freenet.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva> <3ED372DB.1030907@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED372DB.1030907@gmx.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 04:14:51PM +0200, Carl-Daniel Hailfinger wrote:
> Christian,
> this looks supiciously like the problem you are experiencing since
> 2.4.19-pre. Maybe we can fix this for good.

The most I know of this is that someone made it go away by backing out
some ll_rw_blk.c cset.


-- wli
