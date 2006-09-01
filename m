Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWIABQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWIABQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWIABQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:16:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17050 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964777AbWIABQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:16:32 -0400
Date: Fri, 1 Sep 2006 11:16:01 +1000
From: Nathan Scott <nathans@sgi.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Correcting error-prone boolean-statement
Message-ID: <20060901111601.R3186664@wobbly.melbourne.sgi.com>
References: <44F77653.6000606@student.ltu.se> <20060901100745.P3186664@wobbly.melbourne.sgi.com> <44F78A67.1060007@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44F78A67.1060007@student.ltu.se>; from ricknu-0@student.ltu.se on Fri, Sep 01, 2006 at 03:18:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 03:18:31AM +0200, Richard Knutsson wrote:
> Nathan Scott wrote:
> >Are you using XFS on your systems?  What is your strategy for getting this
> >runtime tested going to be?  Or are you delegating that responsibility? :)
> >  
> Sorry, can't say that I do. So pretty please... ;)
> Seriously, I can not find a state when this may fail (if not "if (var == 
> TRUE)" happend to be correct for 'var' != 0 != 1, but that is just a bug 
> waiting to happend).
> But please correct me if I am wrong.

OK, I'll run with it in my own testing for awhile.  I was also curious to
why you didn't remove the other few B_TRUE/B_FALSE occurences?  (and the
typedef)?

cheers.

-- 
Nathan
