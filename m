Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUJYTTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUJYTTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbUJYTRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:17:54 -0400
Received: from mail.tmr.com ([216.238.38.203]:55049 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261253AbUJYTQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:16:14 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [BK PATCHES] ide-2.6 update
Date: Mon, 25 Oct 2004 15:18:47 -0400
Organization: TMR Associates, Inc
Message-ID: <417D5197.5030405@tmr.com>
References: <m3zn2boq1h.fsf@lugabout.cloos.reno.nv.us><58cb370e04102405081d62bf40@mail.gmail.com> <58cb370e04102413156543b72e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1098731285 6653 192.168.12.100 (25 Oct 2004 19:08:05 GMT)
X-Complaints-To: abuse@tmr.com
Cc: James Cloos <cloos@jhcloos.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <58cb370e04102413156543b72e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sun, 24 Oct 2004 12:48:58 -0700, James Cloos <cloos@jhcloos.com> wrote:
> 
>>Are all of the data displayed in /proc/ide/piix et al now available
>>in sysfs?  If so, 'twould've been useful for a small utility -- a
> 
> 
> All these data can be obtained from user-space,
> no need for bloating sysfs.
> 
> 
>>la lsscsi(8) -- that can format that data like the /proc/ide files
>>to have been released before dropping the /proc files....
>>It is a regression to loose convenient access to the controllers'
>>current configs....
> 
> 
> http://home.elka.pw.edu.pl/~bzolnier/atapci/
> 
> released > 2 years ago :)
> 
> works fine but probably needs some cut'n'paste updates

Other than one obvious patch to get rid of all the warnings from putting 
comments after #endif w/o a comment inducer, seems to work...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
