Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVBYAqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVBYAqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 19:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVBYApa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 19:45:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:51192 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262574AbVBYAmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 19:42:32 -0500
Date: Thu, 24 Feb 2005 18:38:06 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: raid6altivec does not compile on ppc32
Message-ID: <20050225003806.GG15818@austin.ibm.com>
References: <jebra9fq6t.fsf@sykes.suse.de> <421E6F10.4060205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E6F10.4060205@zytor.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 04:19:28PM -0800, H. Peter Anvin wrote:
> Andreas Schwab wrote:
> >On ppc32 cur_cpu_spec is an array of pointers, not just a pointer like on
> >ppc64.
> >
> >drivers/md/raid6altivec1.c: In function `raid6_have_altivec':
> >drivers/md/raid6altivec1.c:111: error: request for member `cpu_features' 
> >in something not a structure or union
> >
> 
> I think this is being discussed on the ppc development list.  It's 
> apparently turned into a "we have a problem, let's fix it the right way."

cpu_has_feature() is in 2.6.11-rc4-mm1, it takes care of it.


-Olof
