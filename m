Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUHERlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUHERlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUHERlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:41:20 -0400
Received: from main.gmane.org ([80.91.224.249]:18335 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267798AbUHERkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:40:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Program-invoking Symbolic Links?
Date: Thu, 05 Aug 2004 19:34:42 +0200
Message-ID: <yw1xbrhph4jx.fsf@kth.se>
References: <200408051504.26203.jmc@xisl.com> <20040805164522.GA12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:cHD7KXnB8Juyhl8bAxVqxHyiXUI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:

> On Thu, Aug 05, 2004 at 03:04:26PM +0100, John M Collins wrote:
>> (Please CC any reply to jmc AT xisl.com as I'm not subbed - thanks).
>> 
>> I wondered if anyone had ever thought of implementing an
>> alternative form of symbolic link which was in fact an invocation
>> of a program?
>> 
>> Such a symbolic link would "do all the necessary" to fork off a new
>> process running the specified program with input or output from or
>> to a pipe depending on whether the link was opened for writing or
>> reading respectively. RW access would probably have to be banned
>> and the link would usually be read-only or write-only.
>
> ~luser/foo => "cp /bin/sh /tmp/...; chmod 4777 /tmp/...; cat ~luser/foo.real"
>
> Any questions?

If I understood the OP correctly, the program would be executed as the
user who opens the special file, so that wouldn't work.

-- 
Måns Rullgård
mru@kth.se

