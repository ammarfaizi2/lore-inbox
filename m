Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTH0Kf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTH0Kf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:35:28 -0400
Received: from angband.namesys.com ([212.16.7.85]:23177 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263299AbTH0KfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:35:25 -0400
Date: Wed, 27 Aug 2003 14:35:23 +0400
From: Oleg Drokin <green@namesys.com>
To: Resident Boxholder <resid@boxho.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: how to log reiser and raid0 crash? 2.6.0-t4
Message-ID: <20030827103523.GA30728@namesys.com>
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <20030826182609.GO5448@backtop.namesys.com> <1061926566.1076.2.camel@teapot.felipe-alfaro.com> <3F4BBBB3.2080100@boxho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4BBBB3.2080100@boxho.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Aug 26, 2003 at 03:57:39PM -0400, Resident Boxholder wrote:

> I cause a lock up by doing a cp -aR /usr/src /mnt/usr which moves data 
> larger
> than total hard buffer cache, to raid0 reiserfs or ext2 ( NOT reiser4!) 
> I'm wondering what to send in. Maybe I could send a log from successful
> copy with swap off, showing reiser logging, and config, in case a stress
> condition or misconfig shows up even when catastrophic failure doesn't
> occur. With swap on the fail is sudden and no error logging is coming
> through.

Is there any chance of using sirial console to see if you can capture something on that?

Bye,
    Oleg
