Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWB0TmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWB0TmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWB0TmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:42:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:4741 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751527AbWB0TmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:42:04 -0500
Date: Mon, 27 Feb 2006 14:36:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227193654.GA12788@kvack.org>
References: <20060227190150.GA9121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227190150.GA9121@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 11:01:50AM -0800, Greg KH wrote:
> --- /dev/null
> +++ gregkh-2.6/Documentation/ABI/private/alsa
> @@ -0,0 +1,8 @@
> +What:		Kernel Sound interface
> +Date:		Feburary 2006
> +Who:		Jaroslav Kysela <perex@suse.cz>
> +Description:
> +		The use of the kernel sound interface must be done
> +		through the ALSA library.  For more details on this,
> +		please see http://www.alsa-project.org/ and contact
> +		<alsa-devel@alsa-project.org>

How can something as widely used as sound not work from one kernel version 
to the next, as seems to be implied with the "private" nature of the ABI?  
This is a total cop-out and is IMHO very amateur of the developers.  If 
something like this is to be the case, at the very least the alsa libraries 
need to provide a stable ABI and be shipped with the kernel.

		-ben
