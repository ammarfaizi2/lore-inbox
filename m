Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKXWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTKXWM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:12:28 -0500
Received: from main.gmane.org ([80.91.224.249]:8683 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261240AbTKXWM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:12:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 23:12:24 +0100
Message-ID: <yw1xptfh8lh3.fsf@kth.se>
References: <fa.hevpbbs.u5q2r6@ifi.uio.no> <fa.l1quqni.v405hu@ifi.uio.no>
 <3FC27019.7010402@myrealbox.com>
 <200311242204.hAOM4aZ1000847@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:xmU6on1EAFnVopNW1nJGicc3R2A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

>> Right... but non-privileged users _can't_ delete these extra links, even 
>> if they notice them from the link count.
>
> They can truncate the file to zero length, though, then delete the
> 'original' link, making all of the other links point to the zero
> length file.

It could be tricky to find those extra links if the original has been
deleted, of course.

-- 
Måns Rullgård
mru@kth.se

