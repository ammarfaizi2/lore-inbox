Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbTI1RjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTI1RjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:39:04 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:27193 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262651AbTI1RjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:39:01 -0400
Date: Sun, 28 Sep 2003 18:38:39 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [bk patches] 2.6.x misc updates
Message-ID: <20030928173839.GI5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030928144428.GA16477@gtf.org> <20030928164002.GA4931@redhat.com> <3F77140E.2080402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F77140E.2080402@pobox.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 01:02:06PM -0400, Jeff Garzik wrote:

 > > > Linus, please do a
 > > > 	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5
 > > > This will update the following files:
 > > >    * char/agp/amd64-agp: properly suffix 64-bit constants
 > >Please don't touch this. It needs fixing in a different way
 > >for 32bit.
 > 
 > I don't see how the patch could break anything.  It's obviously correct, 
 > even if the overall code isn't great for IA32.

Actually looking at the spec, the PTEs don't change in 32bit or 64bit
mode, so it should do the right thing. I take back my objection
to your change. Go ahead and apply.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
