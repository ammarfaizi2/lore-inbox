Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWITX54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWITX54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWITX54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:57:56 -0400
Received: from smtp-out.google.com ([216.239.33.17]:2125 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWITX54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:57:56 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=XcW2ohGuKYAr6C2Mh5MZcExS9JWvtURo53drzsw5yvNxM4WsG+UwJRlw8sSbRJZFi
	wqDzhdwN6yXJNJlwFhbuw==
Message-ID: <6599ad830609201657h1756d28eh4a04f85467f30ed2@mail.google.com>
Date: Wed, 20 Sep 2006 16:57:48 -0700
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, clameter@sgi.com
In-Reply-To: <20060920165408.c10e8857.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <1158777240.6536.89.camel@linuxchandra>
	 <6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	 <1158778496.6536.95.camel@linuxchandra>
	 <6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	 <20060920134903.fbd9fea8.pj@sgi.com>
	 <6599ad830609201351k6d72067fpc86069ffb5bb60ba@mail.google.com>
	 <20060920140401.39cc88ab.pj@sgi.com>
	 <6599ad830609201605s2fc1ccbdse31e3e60a50d56bc@mail.google.com>
	 <20060920165408.c10e8857.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Paul Jackson <pj@sgi.com> wrote:
> these various mechanisms, including cpusets.  It would be good to
> persue this common technology infrastructure -before- the kernel to
> user API of these other thingies gets frozen, as the details of just
> what this common code can do conveniently might impact details of the
> kernel API presented to users.

Indeed - although one of the advantages of the patch I sent is that it
can continue to present exactly the same interface, and functionality,
to userspace as the current cpusets code does. It wouldn't be
necessary to change the userspace API until the "generic" requirements
were more baked.

Paul
