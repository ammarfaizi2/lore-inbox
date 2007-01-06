Return-Path: <linux-kernel-owner+w=401wt.eu-S1751178AbXAFEjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbXAFEjz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbXAFEjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:39:55 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:58436 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751178AbXAFEjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:39:55 -0500
X-Greylist: delayed 4162 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 23:39:55 EST
Date: Sat, 6 Jan 2007 05:30:29 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-ID: <20070106033029.GD8772@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20070106023907.GA7766@m.safari.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106023907.GA7766@m.safari.iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 04:39:07 +0200, Sami Farin wrote:
> Linux 2.6.19.1 SMP [2] on Pentium D...
> I was running dt-15.14 [2] and I ran
> "cinfo datafile" (it does mincore()).
> Well it went OK but when I ran "strace cinfo datafile"...:
> 04:18:48.062466 mincore(0x37f1f000, 2147266560, 

Forgot to do "git-whatchanged mm/mincore.c"...
Looks like git and 2.6.19.2 review patch include a fix for mincore.
Maybe it fixes this issue.

-- 
