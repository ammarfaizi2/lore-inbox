Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUAVUfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbUAVUfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:35:51 -0500
Received: from nevyn.them.org ([66.93.172.17]:60322 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S264919AbUAVUfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:35:34 -0500
Date: Thu, 22 Jan 2004 15:35:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Export console functions for use by Software Suspend	nice display
Message-ID: <20040122203529.GB13377@nevyn.them.org>
Mail-Followup-To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1074757083.1943.37.camel@laptop-linux> <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk> <1074796577.12771.81.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074796577.12771.81.camel@laptop-linux>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 07:38:13AM +1300, Nigel Cunningham wrote:
> Hi.
> 
> I'm not sure that write is what I want. At the very least, it will make

Sure it is.  Write some wrapper functions that blat out the ANSI cursor
control sequences, just like anyone who does this from userspace
without using libcurses.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
