Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWDUWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWDUWhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWDUWhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:37:19 -0400
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:4997 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751372AbWDUWhS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:37:18 -0400
Message-Id: <44490A210200003600005366@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 21 Apr 2006 16:36:49 -0600
From: "Doug Thompson" <dthompson@lnxi.com>
To: <mark.gross@intel.com>
Cc: <soo.keong.ong@intel.com>, <steven.carbonari@intel.com>,
       <zhenyu.z.wang@intel.com>, <bluesmoke-devel@lists.sourceforge.net>,
       "Doug Thompson" <dthompson@lnxi.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Problems with EDAC coexisting with BIOS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >Does that fix cover the issue as you have discovered it? Or is there
> >more, or another fix you see?
> 
> No, you should return an error from e752x_probe1 if bit5 is cleared
> already.  To do anything else you are assuming that you are privileged
> to have more knowledge about what the BIOS is doing than you should.
> 
> I'll send the patch to e752x_edac.c this weekend.
> 
> --mgross
> 

great. I don't have immediate access to a jarrell mobo at the moment and
definately no access to a manged one.

thanks

doug t



