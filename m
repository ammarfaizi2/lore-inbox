Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUIKNXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUIKNXd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUIKNXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:23:32 -0400
Received: from open.hands.com ([195.224.53.39]:24473 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268145AbUIKNXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:23:31 -0400
Date: Sat, 11 Sep 2004 14:34:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
Message-ID: <20040911133443.GG24787@lkcl.net>
References: <20040911124106.GD24787@lkcl.net> <4142F4CC.7080708@trash.net> <20040911132935.GF24787@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911132935.GF24787@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 02:29:35PM +0100, Luke Kenneth Casson Leighton wrote:
> On Sat, Sep 11, 2004 at 02:51:24PM +0200, Patrick McHardy wrote:
> > Luke Kenneth Casson Leighton wrote:
> > >decided to put this into a separate module.  based on ipt_owner.c.
> > >does full program's pathname.  like ipt_owner, only suitable for
> > >outgoing connections.
> > 
> > I agree that it would be useful to match the full path, but
> > the patch is broken, as are the owner match's pid-, sid- and
> > command-matching options. You can't grab files->file_lock
> > outside of process context. 
 
 thing is, you see, i know just enough to be dangerous.

 using files->file_lock a) seems to work b) is accepted code in the
 kernel.

 if someone else has the experience and knowledge to fix ipt_owner.c
 i'll quite happily cut/paste that instead - once it's fixed.

 in the meantime...

