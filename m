Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUKCTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUKCTZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUKCTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:25:23 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:61068 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261823AbUKCTY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:24:27 -0500
From: Gene Heskett <gheskett@wdtv.com>
Reply-To: gheskett@wdtv.com
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 14:24:23 -0500
User-Agent: KMail/1.7
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       DervishD <lkml@dervishd.net>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031353.39468.gene.heskett@verizon.net> <yw1x7jp2hi1m.fsf@ford.inprovide.com>
In-Reply-To: <yw1x7jp2hi1m.fsf@ford.inprovide.com>
Organization: occasionally detectable
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411031424.23149.gheskett@wdtv.com>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 13:24:23 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 14:03, Måns Rullgård wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> On Wednesday 03 November 2004 12:44, DervishD wrote:
>>>    Hi Gene :)
>>>
>>> * Gene Heskett <gene.heskett@verizon.net> dixit:
>>>> >    Or write a little program that just 'wait()'s for the
>>>> > specified PID's. That is perfectly portable IMHO. But I must
>>>> > admit that the preferred way should be killing the parent.
>>>> > 'init' will reap the children after that.
>>>>
>>>> But what if there is no parent, since the system has already
>>>> disposed of it?
>>>
>>>    Then the children are reparented to 'init' and 'init' gets rid
>>> of them. That's the way UNIX behaves.
>>
>> Unforch, I've *never* had it work that way.  Any dead process I've
>> ever had while running linux has only been disposable by a reboot.
>
>That's because its parent was still sitting around refusing to
> wait() for them.

Define 'parent' when it was a click on the apps icon on the xwindow 
screen that started it, please.

-- 
Cheers, gene
gheskett at wdtv dot com
99.28% setiathome rank, not too bad for a WV hillbilly
