Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273682AbRI0Qyr>; Thu, 27 Sep 2001 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273688AbRI0Qyh>; Thu, 27 Sep 2001 12:54:37 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:49423 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273682AbRI0QyV>;
	Thu, 27 Sep 2001 12:54:21 -0400
Date: Thu, 27 Sep 2001 09:49:53 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, crispin@wirex.com,
        linux-security-module@wirex.com
Subject: Re: Binary only module overview
Message-ID: <20010927094953.B24460@kroah.com>
In-Reply-To: <20010926164643.B21369@kroah.com> <E15mZyp-0003om-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15mZyp-0003om-00@the-village.bc.nu>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 01:09:27PM +0100, Alan Cox wrote:
> GPL_EXPORT_SYM is coming, has been discussed and tentatively agreed upon
> so that we can for example have libraries of GPL code that are GPL module
> only usable, while still exporting clear interfaces for nonfree users when
> appropriate (eg device drivers)

So in your opinion, would making the LSM public functions use
GPL_EXPORT_SYM (when it is available) increase the odds of the patch
being accepted into the kernel?

thanks,

greg k-h
