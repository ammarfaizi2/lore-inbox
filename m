Return-Path: <linux-kernel-owner+w=401wt.eu-S932270AbXAFXwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbXAFXwr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbXAFXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 18:52:47 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:46213 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932270AbXAFXwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 18:52:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=JY7nq7I8dOHOo5BW+aLrzwro25QjdSFrFhewlnLMpZmimQeGqR2pKdkG+PaOu+sS6xcMP/yYWQHDcPOFBrXoMP1hPeIqdj7RewEeIQu4ter1EHBFIs1fQpSL+3LbVE7tDa83G0ir+lVulMCSdXVjqeKxVfdrbZ+W0JtRXwCTMUs=  ;
X-YMail-OSG: kcQhJ6cVM1mELKGha3hk0Zm3opIhbnEmdzDvNh4ka.f3kDx7C9Q9BaBrOWBBtaT7ZPNwTCsljYLk0e9eJ5_9Y2qJZlUQttXheObCXWTDzFsAhClswFknQZL3Dzkj7Gb3M6boUu_k0xVPRM5_K7XwZar_9ijFsNpTvBOy.wu9nNakPk6TZWYgPVz4ufsS
From: David Brownell <david-b@pacbell.net>
To: Woody Suwalski <woodys@xandros.com>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
Date: Sat, 6 Jan 2007 13:17:25 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>
References: <200701051001.58472.david-b@pacbell.net> <200701051933.26368.david-b@pacbell.net> <459FD993.3070909@xandros.com>
In-Reply-To: <459FD993.3070909@xandros.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200701061317.25567.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2007 9:17 am, Woody Suwalski wrote:
> >> There are PPC, M68K, SPARC, and other boards that could also
> >> use this; ARMs tend to integrate some other RTC on-chip.  ...
> 
> > Let me put that differently.  That should be done as a separate
> > patch, adding (a) that platform_device, and maybe platform_data
> > if it's got additional alarm registers, and (b) Kconfig support
> > to let that work.  I'd call it a "patch #4 of 3".  ;)
> > ...
> 
> I will try to play with the new code on Monday on ARM...

Thanks.  Could you describe your ARM board?  None of mine have an
RTC using this register API.  Does it support system sleep states
(/sys/power/state) with a wakeup-capable (enable_irq_wake) RTC irq? 

- Dave

