Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbTELVxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTELVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:53:47 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:35542 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S262801AbTELVxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:53:35 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Mon, 12 May 2003 15:06:18 -0700
From: David Hinds <dhinds@sonic.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: David Hinds <dahinds@users.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-ID: <20030512150618.B22527@sonic.net>
References: <1052775331.1995.49.camel@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052775331.1995.49.camel@diemos>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 04:35:32PM -0500, Paul Fulghum wrote:
> 
> So, are all the PCMCIA drivers supposed to be changed to not
> release resources in the timer context? And if so, what
> is the new convention?

yes.  The timers should be gotten rid of.

-- Dave
