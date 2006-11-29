Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967586AbWK2T1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967586AbWK2T1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967584AbWK2T1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:27:15 -0500
Received: from rtr.ca ([64.26.128.89]:48913 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S967581AbWK2T1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:27:14 -0500
Message-ID: <456DDF0F.6080501@rtr.ca>
Date: Wed, 29 Nov 2006 14:27:11 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com>
In-Reply-To: <456DD70D.1050808@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berck E. Nash wrote:
> Tejun Heo wrote:
>
>> Then, a series of obsolete STANDBY failures.  Who's issuing these 
>> commands?  It's not libata, libata uses STANDBY (0xe2).  Is it some 
>> kind of gentoo thing?
> 
> Nope, Debian/Unstable.

Most probably my hdparm utility.  It first tries the old STANDBY command,
then tries the newer one if the first one fails.  This should not cause
anybody's system to lock up.

Cheers
