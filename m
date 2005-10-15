Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVJOGrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVJOGrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVJOGrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:47:08 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:26120 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751094AbVJOGrH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PUCsay6J7Wa0ZtxFMlbv72zNN7vgD/tv9Zr+Uq4r1U+elqh+xLLWkDlfRkYjzMK6C77FWOEwUPMNQiYpnzhYorFlcgtKcYn+eEBPZG9i8APEUL+uyBPQ6ZKj75j0kKZUYZoSwZz280nARtoU+n46cDwBoM8lVe9f17eFKQePr8k=
Message-ID: <2cd57c900510142347y41ca98b1gf7172898d2bdc97a@mail.gmail.com>
Date: Sat, 15 Oct 2005 14:47:04 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Forcing an immediate reboot
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1129341050.23895.12.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43505F86.1050701@perkel.com> <1129341050.23895.12.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-14 at 18:46 -0700, Marc Perkel wrote:
> > Is there any way to force an immediate reboot as if to push the reset
> > button in software? Got a remote server that i need to reboot and
> > shutdown isn't working.
>
> If it has Oopsed, and the "reboot" command does not work, then all bets
> are off - kernel memory has probably been corrupted.
>
> Get one of those powerstrips that you can telnet into and power cycle
> things remotely.
>

use reboot on panic.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
