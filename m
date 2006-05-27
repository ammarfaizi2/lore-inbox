Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbWE0XoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbWE0XoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 19:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWE0XoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 19:44:13 -0400
Received: from atpro.com ([12.161.0.3]:20495 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964938AbWE0XoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 19:44:13 -0400
Date: Sat, 27 May 2006 19:43:51 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to send a break?
Message-ID: <20060527234350.GA13881@voodoo.jdc.home>
Mail-Followup-To: Haar =?iso-8859-1?Q?J=E1nos?= <djani22@netcenter.hu>,
	linux-kernel@vger.kernel.org
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/06 02:58:44PM +0200, Haar János wrote:
> Hello, list,
> 
> I wish to know, how to send a "BREAK" to trigger the sysreq functions on the
> serial line, using echo.
> 
> I mean like this:
> 
> #!/bin/bash
> echo "?BREAK?" >/dev/ttyS0
> sleep 2
> echo "m" >/dev/ttyS0
> 

Is there a reason you can't use "echo -n m > /proc/sysrq-trigger"?

Jim.
