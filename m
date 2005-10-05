Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVJEMhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVJEMhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 08:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVJEMhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 08:37:04 -0400
Received: from free.hands.com ([83.142.228.128]:9384 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965146AbVJEMhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 08:37:01 -0400
Date: Wed, 5 Oct 2005 13:36:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005123646.GY10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net> <4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL> <20051005095653.GK10538@lkcl.net> <17219.43860.610103.628963@gargle.gargle.HOWL> <20051005111305.GS10538@lkcl.net> <17219.50271.962920.26612@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.50271.962920.26612@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 04:17:35PM +0400, Nikita Danilov wrote:
> Luke Kenneth Casson Leighton writes:
> 
> [...]
> 
>  > > That's exactly the point: Unix file system model is more flexible than
>  > > alternatives. 
>  > 
>  >  *grin*.  sorry - i have to disagree with you (but see below).
>  > 
>  >  i was called in to help a friend of mine at EDS to do a bastion sftp
>  >  server to write some selinux policy files because POSIX filepermissions
>  >  could not fulfil the requirements.
> 
> First, I was talking about flexibility attained through the separation
> of notions of file and index. 

 oh, right.

> You just claimed elsewhere that this is
> the direction ntfs took 

 with a leap of a few steps, possibly: certainly directly i don't
 remember doing so.

> (with the introduction of hard-links).

 
> Then, every security model has its weakness and corner cases. Try to
> express
> 
>         rw-r-xrw- (0656)
> 
> POSIX bits with canonical NT ACLs (hint: in NT allow-ACEs are
> accumulated).
 
 they used not to be.  accumulative inherited ACLs were introduced
 in NT 5.0.

 and is accumulated ACLs such a bad thing?  it's certainly more
 space-efficient and administrative-efficient.

 l.

