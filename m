Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUENQSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUENQSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUENQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:18:41 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:47795 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261443AbUENQSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:18:39 -0400
Message-ID: <40A4F163.6090802@stanford.edu>
Date: Fri, 14 May 2004 09:18:43 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Andy Lutomirski <luto@myrealbox.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <fa.mu5rj3d.24gtbp@ifi.uio.no>	 <40A4EC72.2020209@myrealbox.com> <1084550518.17741.134.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1084550518.17741.134.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:

> On Fri, 2004-05-14 at 11:57, Andy Lutomirski wrote:
> 
>>Thanks -- turning brain back on, SELinux is obviously better than any
>>fine-grained capability scheme I can imagine.
>>
>>So unless anyone convinces me you're wrong, I'll stick with just
>>fixing up capabilities to work without making them finer-grained.
> 
> 
> Great, thanks.  Fixing capabilities to work is definitely useful and
> desirable.  Significantly expanding them in any manner is a poor use of
> limited resources, IMHO; I'd much rather see people work on applying
> SELinux to the problem and solving it more effectively for the future.
> 

Does this mean I should trash my 'maximum' mask?

(I like 'cap -c = sftp-server' so it can't try to run setuid/fP apps.)
OTOH, since SELinux accomplishes this better, it may not be worth the
effort.

--Andy

