Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWDEVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWDEVSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWDEVSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:18:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34312 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751134AbWDEVSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:18:38 -0400
Date: Wed, 5 Apr 2006 23:18:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kristis Makris <kristis.makris@asu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with symbol names
Message-ID: <20060405211837.GB2398@mars.ravnborg.org>
References: <1144268838.8306.16.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144268838.8306.16.camel@syd.mkgnu.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> So in summary:
> 
>  - Can the kernel from now on start being linked with --warn-common ?

Please try this with an allyesconfig build a enjoy the result.
There is a huge effort involded before getting remotely warning free in
this area.

Your approch seems to neglect the fact that the linker may rearrange
functions if it decide to do so.
And on X86_64 we actually do so with CONFIG_REORDER.

Someone on the list will probarly have som inputs how to do what you try
in a more protable way.

	Sam
