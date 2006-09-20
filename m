Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWITUvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWITUvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWITUvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:51:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30455 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750808AbWITUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:51:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=Mlmhc5eH8V1h/5y5frgJFRLk402TVjf2cUufaqUNoDhbvLLmnGrjg/CwKm7rFU3uJ
	ikLVm+QeUkrzyHPKrfvfg==
Message-ID: <6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
Date: Wed, 20 Sep 2006 13:51:29 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: sekharan@us.ibm.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
In-Reply-To: <20060920134903.fbd9fea8.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <20060920134903.fbd9fea8.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
>
> It seems that cpusets can mimic memory resource groups.  I don't
> see how cpusets could mimic other resource groups.  But maybe I'm
> just being a dimm bulb.
>

I'm not saying that they can - but they could be parallel types of
resource controller for a generic container abstraction, so that
userspace can create a container, and use e.g. memory node isolation
from the cpusets code in conjunction with the resource groups %-based
CPU scheduler.

Paul
