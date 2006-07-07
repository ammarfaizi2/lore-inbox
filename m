Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWGGCIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWGGCIC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWGGCIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:08:02 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3363 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750827AbWGGCIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:08:00 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=UzsCXxkzNqwoWmb5bbHhEp1RXXgSPJ8uecOwwbOS4tdWFE/2sujE3uhk2mZ3BvqV9
	JjOrRAoA5m6iH5MYdLqtQ==
Message-ID: <44ADC1C3.1020106@google.com>
Date: Thu, 06 Jul 2006 19:06:59 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: early pagefault handler
References: <200607050745_MC3-1-C42B-9937@compuserve.com>
In-Reply-To: <200607050745_MC3-1-C42B-9937@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> +page_fault:
> +	cld

My i386 lore is getting a little rusty, can the direction flag actually be
random here?

Regards,

Daniel
