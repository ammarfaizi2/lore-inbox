Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTEIVqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTEIVqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:46:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47785 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263490AbTEIVqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:46:05 -0400
Date: Fri, 9 May 2003 15:00:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Another it87 patch.
Message-ID: <20030509220006.GA2802@kroah.com>
References: <20030508082524.GA32348@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508082524.GA32348@babylon.d2dc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 04:25:24AM -0400, Zephaniah E. Hull wrote:
> This is against my last.

Thanks, I've applied all 3 of these patches to my tree, and will send
them on.

One minor note though:
> +static int log2(int val)
> +{
> +    int answer = 0;
> +    while ((val >>= 1))
> +	answer++;
> +    return answer;
> +}

Can you start using the proper kernel coding style of 8 character tabs?
I've fixed up this in your different patches before applying them, but
in the future it would be nicer if I didn't have to.

thanks,

greg k-h
