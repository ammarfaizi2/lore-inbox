Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUAAMXn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAAMXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:23:43 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:23822 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261298AbUAAMXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:23:42 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: arjanv@redhat.com
Cc: Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1072959055.5717.1.camel@laptop.fenrus.com>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
	 <1072959055.5717.1.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1072959820.1600.252.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 13:23:40 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-01 at 13:10, Arjan van de Ven wrote:
> On Thu, 2004-01-01 at 13:03, Michel Dänzer wrote:
> 
> > How does this patch look?
> 
> ugly.
> 
> I find using #defines for function arguments ugly beyond belief and
> makes it really hard to look through code. I 10x rather have an ifdef in
> the function prototype (which then for the mainstream kernel drm can be
> removed for non-matching versions) than such obfuscation.

That doesn't strike me as particularly beautiful either... is it really
easier for merges, considering that the ugly way is kinda needed for
functions which take different arguments on BSD anyway?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

