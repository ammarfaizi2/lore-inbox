Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWEGWti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWEGWti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWEGWti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 18:49:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7056 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750725AbWEGWth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 18:49:37 -0400
Date: Mon, 8 May 2006 08:46:06 +1000
From: Nathan Scott <nathans@sgi.com>
To: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Cc: linux-kernel@vger.kernel.org, dgc@sgi.com, chrisw@sous-sol.org
Subject: Re: XFS regression on 2.6.17 (Does not happen on 2.6.16.XX)
Message-ID: <20060507224606.GA1224@frodo>
References: <b8bf37780605071536j67ff4152r7f664e438a9a96b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8bf37780605071536j67ff4152r7f664e438a9a96b8@mail.gmail.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 07:36:50PM -0300, Andr? Goddard Rosa wrote:
> Hi, XFS maintainers!

Hi there,

> I got an error when booting 2.6.17-rc3-git13 (I have this same error
> since 2.6.17) that prevents be from booting normally.
> 
> This never happened before until 2.6.17 and is reproducible. I already
> run xfs_check and xfs_repair but they did nothing.

This is likely to be related to write barriers.  I sent a barrier fix
which is probably going to resolve this on last week (I say "probably"
as this is not exactly the same symptoms as before), but looks like
its not yet merged, I'll resend today.

> What data do you need to help me on this issue?

(/me squints -- did you take that photo in a dark room? :)

Can you try the current -mm tree to make sure the problem is fixed
there already?

thanks.

-- 
Nathan
