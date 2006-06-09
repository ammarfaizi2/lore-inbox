Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWFITnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWFITnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWFITnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:43:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:4497 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030455AbWFITnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:43:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cvj01proNlrBvv9JCAIDmkgJ+8G1j6fICmbmp54vR7VFGcnqcA9QWagvdOgCYczPFy+l4xGpj/+n6yHbw9zjB6jEqwbr41UAHCrvnNCm8o6hO4PsGTwe2kV55GbR0W0OC8nyDaA3OHMxhYjvO+B5y+b4m84v9l7F67J5oXtejZU=
Message-ID: <305c16960606091243h10638b2ayb7f1066bb839e496@mail.gmail.com>
Date: Fri, 9 Jun 2006 16:43:41 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1149881504.3894.250.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
	 <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
	 <1149878633.3894.224.camel@mindpipe>
	 <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
	 <1149881504.3894.250.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2006-06-09 at 16:27 -0300, Matheus Izvekov wrote:
> > Sorry, i took a look at the code which handles this and swappiness = 0
> > doesnt seem to imply that process memory will never be swapped out.
> >
>
> OK, then use mlockall().
>
> Lee
>
>

If i make init mlockall, would all child processes be mlocked too?
If not, using this to enforce a system wide policy seems a bit hacky
and non trivial.
