Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbUBKUdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUBKUdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:33:09 -0500
Received: from main.gmane.org ([80.91.224.249]:12741 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266123AbUBKUcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:32:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: printk and long long
Date: Wed, 11 Feb 2004 21:32:51 +0100
Message-ID: <yw1xvfmdwe4s.fsf@kth.se>
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
 <c0e0gr$mcv$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-3502.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:A2GRKkdvJtznQwkCl5iIb0Z1ers=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com (H. Peter Anvin) writes:

> Followup to:  <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
> By author:    Maciej Zenczykowski <maze@cela.pl>
> In newsgroup: linux.dev.kernel
>>
>> On Wed, 11 Feb 2004, vda wrote:
>> 
>> > The character L specifying that a following e, E, f, g, or G
>> > conversion corresponds to a long double argument, or a following
>> > d, i, o, u, x, or X conversion corresponds to a long long argument.
>> > Note that long long is not specified in ANSI C and therefore
>> > not portable to all architectures.
>> 
>> [ personally I'd say screw the un-portable architectures ;) ]
>> Long long is here to stay.
>
> long long is C99, so it's *definitely* here to say.  The conversion specifier
> is "ll" not "L", however.

What is the proper way to deal with printing an int64_t when int64_t
can be either long or long long depending on machine?

-- 
Måns Rullgård
mru@kth.se

