Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316919AbSE3XUQ>; Thu, 30 May 2002 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316927AbSE3XUP>; Thu, 30 May 2002 19:20:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53007
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316919AbSE3XUP>; Thu, 30 May 2002 19:20:15 -0400
Date: Thu, 30 May 2002 16:20:10 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Processes stuck in D state with autofs + smbfs
Message-ID: <20020530232010.GE1136@matchmail.com>
Mail-Followup-To: Urban Widmark <urban@teststation.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020530200332.GD1136@matchmail.com> <Pine.LNX.4.33.0205302326400.4267-100000@cola.enlightnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 11:41:55PM +0200, Urban Widmark wrote:
> On Thu, 30 May 2002, Mike Fedyk wrote:
> 
> > Yes, the remote server was shut down and caused this problem.
> 
> Then that is probably why it fails, the NMI or any other problem is less 
> likely. Please try:
> http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.19-pre9-poll.patch
> 
> I haven't tested this particular patch, but it is a re-diff of an old one.
> Should be ok with -pre6 too.
>

Oh, I'll update to pre9, no problem.  Have any previous patches been tested
with smp?

> You don't need to modify samba, but you do need to enable "SMBFS Receive
> timeout" in the kernel config.

Got it.

I'll give it a test and let you know.

Mike
