Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266384AbUFQFru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266384AbUFQFru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266385AbUFQFru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:47:50 -0400
Received: from havoc.gtf.org ([216.162.42.101]:19179 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266384AbUFQFrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:47:49 -0400
Date: Thu, 17 Jun 2004 01:47:46 -0400
From: David Eger <eger@havoc.gtf.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Message-ID: <20040617054746.GA24184@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere> <20040617022100.GA11774@havoc.gtf.org> <20040617051931.GA1378@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617051931.GA1378@middle.of.nowhere>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 07:19:31AM +0200, Jurriaan wrote:
> 
> Unfortunately, this doesn't fix it for me.
> 
> horizontal scrolling in angband is still very broken, and vertical
> scrolling (even as simple as recalling previous command-lines in bash)
> is also still broken.

/me tries 16 bpp for the first time.  
ah. you do have a different problem.
sorry about that, i'll take a look into it...
  ( i ported the accel fns for radeon from the XFree project,
    so i've got a special interest in getting this right... )

-dte
