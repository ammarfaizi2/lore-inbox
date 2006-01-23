Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWAWPFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWAWPFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWAWPFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:05:45 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:6431 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751459AbWAWPFo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:05:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OBSyTB9VZ81bjJahW5TAh9eRkN3eoiCWbti+yhQFq7qAJkFaVOCW9a3CI+sAjmTtMoR3MRVf12y9/HiWwqSRj0ipDkKC3abU+WLY94vLYwtfQAtyqdrm8d06EkkyF4fd2s0+dmUoIygnBIbHiBtb2Q6tBhA4yT8HNZDffZTOmvI=
Message-ID: <728201270601230705k25e6890ejd716dbfc393208b8@mail.gmail.com>
Date: Mon, 23 Jan 2006 09:05:41 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: "Barry K. Nathan" <barryn@pobox.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601212108.41269.a1426z@gawab.com>
	 <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
	 <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Michael Loftis <mloftis@wgops.com> wrote:
>
> > FWIW, Mac OS X is one step closer to your vision than the typical
> > Linux distribution: It has a directory for swapfiles -- /var/vm -- and
> > it creates new swapfiles there as needed. (It used to be that each
> > swapfile would be 80MB, but the iMac next to me just has a single 64MB
> > swapfile, so maybe Mac OS 10.4 does something different now.)
> /var/vm/swap*
>  64M    swapfile0
>  64M    swapfile1
> 128M    swapfile2
> 256M    swapfile3
> 512M    swapfile4
> 512M    swapfile5
> 1.5G    total
>

Linux also supports multiple swap files . But these are more
beneficial if there are more than one disk in the system so that i/o
can be done in parallel. These swap files may be activated at run time
based on some criteria.

Regards
Ram Gupta
