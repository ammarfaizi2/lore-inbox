Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTAaWmx>; Fri, 31 Jan 2003 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTAaWmx>; Fri, 31 Jan 2003 17:42:53 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:61568 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262871AbTAaWmu>;
	Fri, 31 Jan 2003 17:42:50 -0500
Message-ID: <3E3AFDD1.7000909@candelatech.com>
Date: Fri, 31 Jan 2003 14:50:57 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       Konrad Eisele <eiselekd@web.de>
Subject: Re: Perl in the toolchain
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131204132.GA1226@mars.ravnborg.org>
In-Reply-To: <20030131204132.GA1226@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jan 31, 2003 at 02:48:37PM -0500, Jeff Garzik wrote:
> 
>>On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
>>
>>>Generally, we've been trying to not make perl a prequisite for the kernel 
>>>build, and I'd like to keep it that way. Except for some arch specific 
>>
>>That's pretty much out the window when klibc gets merged, so perl will
>>indeed be a build requirement for all platforms...
> 
> 
> None of the perl scripts looks complicated.
> Obivious question is if the same functionality could be achived by a simple
> c program.
> In the tool chain we use small C utilities in favour of for example
> perl scripts in several places.

I've seen a lot of machines, and I've yet to see one that has the gcc toolchain
but not perl.  Why do you want to keep perl out?

Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


