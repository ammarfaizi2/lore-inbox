Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267316AbUHIWZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUHIWZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:25:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:23994 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S267316AbUHIWXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:23:32 -0400
Date: Mon, 9 Aug 2004 15:23:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Weeks <greg.weeks@timesys.com>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
Message-ID: <20040809222328.GB22109@smtp.west.cox.net>
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 01:42:08PM -0400, Dan Malek wrote:

> 
> On Aug 9, 2004, at 12:56 PM, Tom Rini wrote:
> 
> >Has anyone had a problem with this?  If not, I'll go and pass it
> >along...
> 
> The default rounding mode should be whatever is defined
> by IEEE.  I thought the emulator used the proper default value
> and if want something different it should be selected by
> the control register.  Maybe the emulator isn't implementing
> the control register properly.

Or we had the wrong default?  Greg, any chance you've looked into this
more?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
