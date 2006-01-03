Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWACLeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWACLeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWACLeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:34:13 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:63131 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751375AbWACLeN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:34:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KbnW3jpADoKUGgOUo5BRRtZMLHwy1e1IX2C42pKPFKH/68jdQqMaZTBAz0eNv4oKORinoRlvs1S2apgPPQ1KzRy/88457lIQNEOTjxEIHAjJRnWgyMGvjfn8eHuhYOM7PHGdqPuCJ68aYVkFvctwT0DRg168xPz8G4UFMVoNsjU=
Message-ID: <6bffcb0e0601030334oae6f730x@mail.gmail.com>
Date: Tue, 3 Jan 2006 12:34:11 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060103112716.GA2612@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103094720.GA16497@elte.hu>
	 <6bffcb0e0601030321h62aab08bi@mail.gmail.com>
	 <20060103112716.GA2612@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/06, Ingo Molnar <mingo@elte.hu> wrote:
> ok, that's the lost-preemption-check still triggering. Does the system
> otherwise work as expected? The message should be harmless - unless you
> are also seeing other problems.
>
>         Ingo
>

So...
Networking doesn't work at all (I disabled it, for now - I have got
oops flood, probably while loading ipv6 module).
Xorg doesn't work.

Regards,
Michal Piotrowski
