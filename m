Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbUKCTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbUKCTiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKCTfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:35:32 -0500
Received: from 200.80-202-166.nextgentel.com ([80.202.166.200]:2252 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261846AbUKCTer convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:34:47 -0500
To: gheskett@wdtv.com
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031353.39468.gene.heskett@verizon.net>
	<yw1x7jp2hi1m.fsf@ford.inprovide.com>
	<200411031424.23149.gheskett@wdtv.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Wed, 03 Nov 2004 20:34:22 +0100
In-Reply-To: <200411031424.23149.gheskett@wdtv.com> (Gene Heskett's message
 of "Wed, 3 Nov 2004 14:24:23 -0500")
Message-ID: <yw1x3bzqhgld.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gheskett@wdtv.com> writes:

> On Wednesday 03 November 2004 14:03, Måns Rullgård wrote:
>>Gene Heskett <gene.heskett@verizon.net> writes:
>>> On Wednesday 03 November 2004 12:44, DervishD wrote:
>>>>    Hi Gene :)
>>>>
>>>> * Gene Heskett <gene.heskett@verizon.net> dixit:
>>>>> >    Or write a little program that just 'wait()'s for the
>>>>> > specified PID's. That is perfectly portable IMHO. But I must
>>>>> > admit that the preferred way should be killing the parent.
>>>>> > 'init' will reap the children after that.
>>>>>
>>>>> But what if there is no parent, since the system has already
>>>>> disposed of it?
>>>>
>>>>    Then the children are reparented to 'init' and 'init' gets rid
>>>> of them. That's the way UNIX behaves.
>>>
>>> Unforch, I've *never* had it work that way.  Any dead process I've
>>> ever had while running linux has only been disposable by a reboot.
>>
>>That's because its parent was still sitting around refusing to
>> wait() for them.
>
> Define 'parent' when it was a click on the apps icon on the xwindow 
> screen that started it, please.

Run "ps axf".

-- 
Måns Rullgård
mru@inprovide.com
