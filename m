Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVFIQMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVFIQMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVFIQMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:12:52 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:45522 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S262282AbVFIQMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:12:46 -0400
From: "Dan A. Dickey" <dan.dickey@savvis.net>
Reply-To: dan.dickey@savvis.net
Organization: WAM!NET a Division of SAVVIS, Inc.
To: Andrew Morton <akpm@osdl.org>
Subject: Re: System state too high for too long...
Date: Thu, 9 Jun 2005 11:12:34 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200506071125.41543.dan.dickey@savvis.net> <200506081158.40461.dan.dickey@savvis.net> <20050608143501.791edfd2.akpm@osdl.org>
In-Reply-To: <20050608143501.791edfd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506091112.34425.dan.dickey@savvis.net>
X-OriginalArrivalTime: 09 Jun 2005 16:12:34.0520 (UTC) FILETIME=[0BD1DD80:01C56D0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 16:35, Andrew Morton wrote:
> "Dan A. Dickey" <dan.dickey@savvis.net> wrote:
> >
> >    8704 kernel_map_pages                          93.5914
> 
> Ah.  CONFIG_DEBUG_PAGEALLOC can be most expensive.  Please disable it and
> try again.

Andrew,
Thank you very much!  That appears to have been it.
I think it may have crept into my config way back when
when I enabled kernel debugging so I could get the
Alt-SysRq stuff enabled.  I didn't realize I had enabled
other things to be turned on as well.  This certainly
taught me to take a closer look at my config when
changing it.  Thanks again.
My system is much more speedy at compiles now!
	-Dan

-- 
Dan A. Dickey
dan.dickey@savvis.net

SAVVIS
Transforming Information Technology
