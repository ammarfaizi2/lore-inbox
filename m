Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUHBMxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUHBMxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHBMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:53:32 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:54024 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S266472AbUHBMxb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:53:31 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in register_chrdev, what did I do?
References: <yw1xwu0i1vcp.fsf@kth.se> <yw1xllgxg9v4.fsf@kth.se>
	<1091439574.2826.3.camel@laptop.fenrus.com> <yw1xd629g8bc.fsf@kth.se>
	<20040802101037.GA14477@devserv.devel.redhat.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Mon, 02 Aug 2004 14:53:21 +0200
In-Reply-To: <20040802101037.GA14477@devserv.devel.redhat.com> (Arjan van de
 Ven's message of "Mon, 2 Aug 2004 12:10:37 +0200")
Message-ID: <yw1x8ycxg0qm.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

>> The problem I see is that a modules contain information about certain
>> compiler flags used, e.g. -mregparm, but insmod still attempts to load
>> them even they do not match the kernel.  This is independent of what
>> build system you used.
>
> that is odd, which modutils is that ? Afaik insmod is supposed to just
> refuse (and I've seen it do that as well)

A little embarrassing perhaps, but it was quite old.  I'm upgrading to
3.0.

-- 
Måns Rullgård
mru@kth.se
