Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWAOT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWAOT7x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWAOT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:59:53 -0500
Received: from [63.81.120.158] ([63.81.120.158]:62197 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S932125AbWAOT7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:59:53 -0500
Message-ID: <43CAA9F2.2050807@mvista.com>
Date: Sun, 15 Jan 2006 12:00:50 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [robust-futex-1] futex: robust futex support
References: <43C84D4B.70407@mvista.com>	 <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>	 <746DBAD6-855A-11DA-A824-000A959BB91E@mvista.com> <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
In-Reply-To: <a36005b50601142118h3a07a640ra668dab13129683b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:

>On 1/14/06, david singleton <dsingleton@mvista.com> wrote:
>  
>
>>can you suggest some error codes you like to use?  I'll use
>>whatever you suggest.
>>    
>>
>
>How about EADDRNOTAVAIL.  The error message kind of makes sense, even
>though "address" is misused.  And there definitely won't be a clash
>with other error codes because it's currently only used in network
>contexts.
>  
>
Will do.  I'm testing a patch that addresses Andi's suggestions now and 
I'll add
the return code today.

thanks

