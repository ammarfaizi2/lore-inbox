Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWC2Wo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWC2Wo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWC2Wo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:44:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60558 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750948AbWC2Wo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:44:57 -0500
Message-ID: <442B0DDF.7090405@vilain.net>
Date: Thu, 30 Mar 2006 10:44:47 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
       akpm@osdl.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Pavel Emelianov <xemul@sw.ru>, Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>	 <20060324211917.GB22308@MAIL.13thfloor.at>	 <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>  <4428F902.1020706@sw.ru> <1143664234.9731.47.camel@localhost.localdomain>
In-Reply-To: <1143664234.9731.47.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>On Tue, 2006-03-28 at 12:51 +0400, Kirill Korotaev wrote:
>  
>
>>Eric, we have a GIT repo on openvz.org already:
>>http://git.openvz.org 
>>    
>>
>
>Git is great for getting patches and lots of updates out, but I'm not
>sure it is idea for what we're trying to do.  We'll need things reviewed
>at each step, especially because we're going to be touching so much
>common code.
>
>I'd guess set of quilt (or patch-utils) patches is probably best,
>especially if we're trying to get stuff into -mm first.
>  
>

The apparent problem is that the git commit history on a branch cannot
be unwound.  However, that is fine - just make another branch and put
your new sequence of commits there.

Tools exist that allow you to wind and unwind the commit history
arbitrarily to revise patches before they are published on a branch that
you don't want to just delete.  For instance:

stacked git

  http://www.procode.org/stgit/

or patchy git

  http://www.spearce.org/2006/02/pg-version-0111-released.html

are examples of such tools.

I recommend starting with stacked git, it really is nice.

Sam.
