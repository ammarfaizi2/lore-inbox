Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWILObq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWILObq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbWILObq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:31:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:3392 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965248AbWILObp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:31:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TjqCCP4mvbhg6rs9nFEG3VrtiNelZsN0Y0VDjB+op23ElJOG1OHmfhv3Joimf5csZfi4reYGxA2xFpqLILly0O2eK+iOAhSfv4lveXlYYgwmub90nh8j0SRlL/a8BzXvVIbljydmS/7fWjqIPnjsAZqYJMRin/BwpmQCx58xUJ4=
Message-ID: <4506C4D3.7030304@gmail.com>
Date: Tue, 12 Sep 2006 16:31:47 +0200
From: guest01 <guest01@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.5) Gecko/20060719 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: calling kernel syscall manually
References: <4506A295.6010206@gmail.com> <1158068045.9189.93.camel@hades.cambridge.redhat.com>
In-Reply-To: <1158068045.9189.93.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> The third one has always been broken on i386 for PIC code and was
> pointless anyway, since glibc provides this functionality. The kernel
> method has been removed from userspace visibility all architectures, and
> we plan to remove it entirely in 2.6.19 since it's not at all useful. 
> 
> However, there was a patch which was sneaked to Linus in private which
> reverted that cleanup on i386 and x86_64 and made them visible again --
> but they'll be going away again on those two architectures shortly;
> hopefully before 2.6.18.
> 
> Don't bother with it -- just use glibc's syscall().
> 

Thx for the fast reply. I wouldn't use the third method (3 -> using
kernel directly) in one of my projects, but I have to try each one of
the three methods for a small assignment (unfortunately, not every
assignment is very useful at a university :-))
So, I would be very grateful if you have some code snippets or further
information for me about method #3.

thx again
regards
Peda


