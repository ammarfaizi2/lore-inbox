Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUIKNSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUIKNSX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUIKNSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 09:18:23 -0400
Received: from open.hands.com ([195.224.53.39]:17817 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268141AbUIKNSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 09:18:22 -0400
Date: Sat, 11 Sep 2004 14:29:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
Message-ID: <20040911132935.GF24787@lkcl.net>
References: <20040911124106.GD24787@lkcl.net> <4142F4CC.7080708@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4142F4CC.7080708@trash.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 02:51:24PM +0200, Patrick McHardy wrote:
> Luke Kenneth Casson Leighton wrote:
> >decided to put this into a separate module.  based on ipt_owner.c.
> >does full program's pathname.  like ipt_owner, only suitable for
> >outgoing connections.
> 
> I agree that it would be useful to match the full path, but
> the patch is broken, as are the owner match's pid-, sid- and
> command-matching options. You can't grab files->file_lock
> outside of process context. 

 what should be done instead?

 what code is there around that i can copy that does a proper job?

 l.

