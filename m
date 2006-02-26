Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBZVxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBZVxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWBZVxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:53:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:32184 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750926AbWBZVxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:53:41 -0500
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
	warnings
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
	 <9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 16:53:39 -0500
Message-Id: <1140990819.24141.176.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 22:49 +0100, Jesper Juhl wrote:
> On 2/26/06, Nix <nix@esperi.org.uk> wrote:
> > (i.e., there's a reason that warning uses the word *might*.)
> >
> The compiler says "might be used uninitialized" when it cannot
> determine if a variable will be initialized before first use or not.

Quoting the "silence gcc warning" thread:

"Really, this is a gcc bug.  My version of the compiler:

gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)

Doesn't give this warning.  And, since the loop has fixed parameters,
gcc should see not only that it's always executed, but that it could be
unrolled."

Lee

