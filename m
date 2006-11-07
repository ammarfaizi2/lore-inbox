Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753022AbWKGUBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbWKGUBA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbWKGUBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:01:00 -0500
Received: from smtp-out.google.com ([216.239.45.12]:63239 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753021AbWKGUA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:00:59 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=hjurjckmi/88UXSzrs3ZDVSmAksddf0iAsNVSUCiXu1PSgA34TxSsfTaEn/kiU422
	LZFA4zeUOY3H1OncikNsg==
Message-ID: <6599ad830611071200l12c47860o7a941721f02b18cf@mail.gmail.com>
Date: Tue, 7 Nov 2006 12:00:46 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
In-Reply-To: <20061107115823.a96ab4f8.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030031531.8c671815.pj@sgi.com>
	 <20061101172540.GA8904@in.ibm.com>
	 <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com>
	 <20061106124948.GA3027@in.ibm.com>
	 <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com>
	 <20061107104118.f02a1114.pj@sgi.com>
	 <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com>
	 <20061107111131.48a9ae49.pj@sgi.com>
	 <6599ad830611071124p7e0d5b20r67bbc8f8d75b3f44@mail.gmail.com>
	 <20061107115823.a96ab4f8.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Paul Jackson <pj@sgi.com> wrote:
> > > So why is this CONFIG_* option separate?  When would I ever not
> > > want it?
> >
> > If you weren't bothered about having the legacy semantics.
>
> You mean if I wasn't bothered about -not- having the legacy semantics?
>
> Let me put this another way - could you drop the
> CONFIG_CPUSETS_LEGACY_API option, and make whatever is needed to
> preserve the current cpuset API always present (if CPUSETS themselves
> are configured, of course)?

Yes.

>
> If you're reluctant to do so, why?

As I said, mainly /proc pollution.

But it's not a big deal, so I can drop it unless there's a strong
argument from others in favour of keeping it.

Paul
