Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUEGRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUEGRXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbUEGRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 13:23:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:13075 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263687AbUEGRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 13:23:38 -0400
Message-ID: <409BC7A7.4060203@techsource.com>
Date: Fri, 07 May 2004 13:30:15 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>, vonbrand@inf.utfsm.cl,
       nickpiggin@yahoo.com.au, jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <20040506130846.GA241@elf.ucw.cz> <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain> <20040507165700.GE18175@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040507165700.GE18175@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:
> Hi!
> 
> 
>>>Perhaps what we really want is "swap_back_in" script? That way you
>>>could do "updatedb; swap_back_in" in cron and be happy.
>>
>>swapoff -a; swapon -a
> 
> 
> Good point... it will not bring back executable pages, through.
> 
> 								Pavel

Wouldn't this also be a problem if you are using more memory than you 
have physical RAM?

