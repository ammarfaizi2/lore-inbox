Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVHJN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVHJN6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVHJN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:58:55 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:14757 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965114AbVHJN6y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:58:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j1O4sS+i3rMA9BQntUZJ7DbrhP3wF43c4/2fE8dJcDEw+NLu+AmcwLtcvxToAOaw18bXCrRAEziUHd7tFgHt7ehd04qe0vhq6SlKGQdWVRxL+hljlB6lPpKIvW5kvF2LKoOZawb0gyb4ErhUT+vNwYWF3Dxg1/+e5xP02dAsr0I=
Message-ID: <9268368b05081006585ca7a415@mail.gmail.com>
Date: Wed, 10 Aug 2005 09:58:49 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Todd Poynor <tpoynor@mvista.com>
Subject: Re: [linux-pm] PowerOP 1/3: PowerOP core
Cc: Geoff Levand <geoffrey.levand@am.sony.com>, cpufreq@lists.linux.org.uk,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <42F94B68.6060107@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
	 <42F8D4C5.2090800@am.sony.com> <42F94B68.6060107@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If these general ideas of arbitrary platform power parameters and
> operating points are deemed worthy of continued consideration, I'll
> propose what I view is the next step: interfaces to create and activate
> operating points from userspace.
> 
> At that point it should be possible to write power policy management
> applications for systems that can benefit from this generalized notion
> of operating points: create the operating points that match the system
> usage models (in the case of many embedded systems, the system is some
> mode with different power/performance characteristics such as audio
> playback vs. mobile phone call in progress) and power needs (e.g., low
> battery strength vs. high strength) and activate operating points based
> on events received (new app running, low battery warning, etc.).
> 
> Any opinions on all that?  Thanks,
> 
> --
> Todd

Hi,

I'd like to have an idea of how the powerop would evolve to address:

a) exporting all operating points to sysfs - that would be useful for
a policy manager in user space, or the user policy will already be
aware of the ops?

b) Constraints: if I would like to change to a op and such a
transition is not allowed in hardware, what part of the software will
test it? The set/get powerop functions, the higher layers or even some
lower layer (don't know if expected) ?

thanks,

Daniel
-- 
10LE - Linux
INdT - Manaus - Brazil
