Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUE0PIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUE0PIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUE0PIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:08:13 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:38086 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S264692AbUE0PIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:08:10 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6 
In-reply-to: Your message of "Thu, 27 May 2004 16:59:35 +0200."
             <20040527145935.GE23194@wohnheim.fh-wedel.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Fri, 28 May 2004 01:08:02 +1000
Message-ID: <4382.1085670482@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 16:59:35 +0200, 
=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> wrote:
>On Thu, 27 May 2004 16:49:16 +0200, Andrea Arcangeli wrote:
>> On Thu, May 27, 2004 at 04:15:47PM +0200, Jörn Engel wrote:
>> An equivalent script is the one from Keith
>> Owens checking the vmlinux binary after compilation but I'm afraid
>> people runs that one only after the fact.
>
>Plus the script is wrong sometimes.  I have had trouble with sizes
>around 4G or 2G, and never found the time to really figure out what's
>going on.  Might be an alloca thing that got misparsed somehow.

Some code results in negative adjustments to the stack size on exit,
which look like 4G sizes.  My script checks for those and ignores them.
/^[89a-f].......$/d;

