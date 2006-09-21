Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWIUWJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWIUWJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWIUWJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:09:55 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751670AbWIUWJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:09:54 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=rhOnu8L0jkWH1expChxHKbSfFooqWvbQHzLuIQUy3GyJjASqvDPlIXaeAuA39abQp
	+NGWieuplmxXAZ33AUWAA==
Message-ID: <6599ad830609211509x17f0306qbe6d0ef86b86cbc9@mail.google.com>
Date: Thu, 21 Sep 2006 15:09:47 -0700
From: "Paul Menage" <menage@google.com>
To: sekharan@us.ibm.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Paul Jackson" <pj@sgi.com>,
       rohitseth@google.com, devel@openvz.org, clameter@sgi.com
In-Reply-To: <1158875062.6536.210.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201252030.32409@schroedinger.engr.sgi.com>
	 <1158798715.6536.115.camel@linuxchandra>
	 <20060920173638.370e774a.pj@sgi.com>
	 <6599ad830609201742h71d112f4tae8fe390cb874c0b@mail.google.com>
	 <1158803120.6536.139.camel@linuxchandra>
	 <6599ad830609201852k12cee6eey9086247c9bdec8b@mail.google.com>
	 <1158869186.6536.205.camel@linuxchandra>
	 <6599ad830609211310s4e036e55h89bab26432d83c11@mail.google.com>
	 <1158875062.6536.210.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
>
> >
> > But, there's no reason that the OpenVZ resource control mechanisms
> > couldn't be hooked into a generic process container mechanism along
> > with cpusets and RG.
>
> Isn't that one of the things we are trying to avoid (each one having
> their own solution, especially when we _can_ have a common solution).

Can we actually have a single common solution that works for everyone,
no matter what their needs? It's already apparent that there are
multiple different and subtly incompatible definitions of what "memory
controller" means and needs to do. Maybe these can be resolved - but
maybe it's better to have, say, two simple but very different memory
controllers that the user can pick between, rather than one big and
complicated one that tries to please everyone.

Paul
