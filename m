Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWCSOwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCSOwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 09:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWCSOwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 09:52:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48536 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751083AbWCSOwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 09:52:14 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
References: <20060306235248.20842700@localhost.localdomain>
	<20060306235249.880CB28A@localhost.localdomain>
	<20060307012438.GL27946@ftp.linux.org.uk>
	<1141696548.9274.48.camel@localhost.localdomain>
	<20060307015741.GM27946@ftp.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 19 Mar 2006 07:50:42 -0700
In-Reply-To: <20060307015741.GM27946@ftp.linux.org.uk> (Al Viro's message of
 "Tue, 7 Mar 2006 01:57:41 +0000")
Message-ID: <m13bhexzct.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> On Mon, Mar 06, 2006 at 05:55:48PM -0800, Dave Hansen wrote:
>> On Tue, 2006-03-07 at 01:24 +0000, Al Viro wrote:
>> > This is disgusting.  Please, don't pile more and more complexity into
>> > sysctl_table - it's already choke-full of it and needs to be simplified,
>> > not to grow more crap.
>> 
>> I don't completely disagree.  It certainly isn't the most elegant
>> approach I've ever seen.
>> 
>> Any ideas on ways we could simplify it?  I was thinking that we could
>> get rid of the .data member and allow access only via the mechanism I
>> just introduced.  It would be pretty easy to make some macros to
>> generate "simple" access functions for the existing global variables.
>
> I'll resurrect the sysctl-cleanups tree and drop it on kernel.org tonight.

Has that happened yet?

I just looked and I didn't see anything up there.

Eric
