Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWFJWrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWFJWrc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWFJWrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:47:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:48704 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161043AbWFJWrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:47:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4pDFR6UB290Ene2UwV68qhyI5r0teXSDUE39Lkop3Fmv4rEDY0n2SyfouZuc+UnC62ccoxuQnYWEFDjsy4EG5BgKz/azvvrkdDeoFCYr+ylRK4U6pRMvzxt2L/iFhwk7l8JSmnGVnRoXSq9OH1rNNRsr4Ek4RnJQcdD4yTN+og=
Message-ID: <4d8e3fd30606101547x46b94058u3bb48ba8d25dc48d@mail.gmail.com>
Date: Sun, 11 Jun 2006 00:47:30 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.4.0
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> > The latest feature release GIT 1.4.0 is available at the
> > usual places:
> >
> >         http://www.kernel.org/pub/software/scm/git/
>
> Cannot pull:
>
> paolo@Italia:~/git$ git pull
> error: no such remote ref refs/heads/jc/bind
> Fetch failure: git://www.kernel.org/pub/scm/git/git.git

Ok, solved doing (as suggested on #git)
/.git/remotes$ vi origin
and removed:
Pull: jc/bind:jc/bind

What happened to that branch?

Thanks.

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
