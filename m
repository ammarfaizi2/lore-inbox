Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTE1XHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTE1XHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:07:32 -0400
Received: from c177031.adsl.hansenet.de ([213.39.177.31]:29929 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S261564AbTE1XH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:07:28 -0400
Message-ID: <3ED543F5.2020308@portrix.net>
Date: Thu, 29 May 2003 01:19:17 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: what happened to i2c-proc
References: <m3d6i3avnk.fsf@ccs.covici.com> <20030528202921.GA8349@localhost>
In-Reply-To: <20030528202921.GA8349@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez wrote:
> On Wednesday, 28 May 2003, at 12:22:23 -0400,
> John Covici wrote:
> 
> 
>>I am trying to compile appropriate modules for lm sensors in 2.5.70,
>>but there seems to be no way to configure i2c-proc -- it seems to be
>>there for other architectures, but not for i386.
>>
> 
> Or maybe something changed in the meantime, and problems are in
> user-space, the fact is it doesn't work:
> 
> server:~# sensors -v
> sensors version 2.6.5
> 

The sensors proc interface didn't make it to 2.5. You have to use sysfs 
to check the sensors (/sys/devices/legacy/...). Userspace didn't get 
converted yet, so all libsensor based programs (ie. all) don't work anymore

Jan

