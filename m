Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWGTILp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWGTILp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 04:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWGTILp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 04:11:45 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:14736 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S964895AbWGTILo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 04:11:44 -0400
Date: Thu, 20 Jul 2006 10:11:43 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Neil Brown <neilb@suse.de>
Cc: Janos Farkas <chexum+dev@gmail.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] nfs problems with 2.6.18-rc1
Message-ID: <20060720081143.GA1408@janus>
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu> <17594.51834.20365.820166@cse.unsw.edu.au> <priv$efbe06145615$0a94d550eb@200607.gmail.com> <priv$8d118c145627$464a3143cd@200607.shadow.banki.hu> <17597.28376.805867.197599@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17597.28376.805867.197599@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 09:29:28AM +1000, Neil Brown wrote:
[...]
> 
> > 13:37:51.254708 access fh Unknown/0100000100FD000002000000755104000AA487A20000001F0AA487A200030001 001f
> > 13:37:51.255375 reply ok 32 access ERROR: Permission denied attr:
> 
> 'access' should never return 'Permission denied' so there is
> definitely something wrong here.  I was expected nfserr_acces rather
> than nfserr_perm...

Maybe a silly remark but:

	EACCES = Permission denied
	EPERM = Operation not permitted

-- 
Frank
