Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTBNRxb>; Fri, 14 Feb 2003 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbTBNRxb>; Fri, 14 Feb 2003 12:53:31 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:31616 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261581AbTBNRxb>; Fri, 14 Feb 2003 12:53:31 -0500
Date: Fri, 14 Feb 2003 19:03:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Larry Hileman <LHileman@snapappliance.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about 48 bit IDE on 2.4.18 kernel
Message-ID: <20030214180320.GG200@louise.pinerecords.com>
References: <057889C7F1E5D61193620002A537E8690B5A2D@NCBDC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <057889C7F1E5D61193620002A537E8690B5A2D@NCBDC>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [LHileman@snapappliance.com]
> 
> Moving to 2.4.20/21 is a large effort here.  If I need to implement
> the larger drives in 2.4.18, I'd like to make sure that this
> has not already been done and that I have the latest code.

Well, the patches to the IDE layer in patch-2.4.19 & patch-2.4.20
are both relatively numerous and large, but should still be quite
straightforward to extract, given you're good with various diff
utils.  The block layer changes that Alan mentions will be minimal
and probably easy to trace.

-- 
Tomas Szepe <szepe@pinerecords.com>
