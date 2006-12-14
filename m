Return-Path: <linux-kernel-owner+w=401wt.eu-S964973AbWLNWlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWLNWlh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWLNWlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:41:37 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:11233 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964974AbWLNWlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:41:36 -0500
Message-ID: <4581D355.1000701@oracle.com>
Date: Thu, 14 Dec 2006 14:42:29 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
References: <20061207004838.4d84842c.randy.dunlap@oracle.com> <20061214223850.GC25114@vasa.acc.umu.se>
In-Reply-To: <20061214223850.GC25114@vasa.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Thu, Dec 07, 2006 at 12:48:38AM -0800, Randy Dunlap wrote:
> 
> [snip]
> 
>> +but no space after unary operators:
>> +		sizeof  ++  --  &  *  +  -  ~  !  defined
> 
> Uhm, that doesn't compute...  If you don't put a space after sizeof,
> the program won't compile.
> 
> int c;
> printf("%d", sizeofc);

Uh, we prefer not to see "sizeof c".  IOW, we prefer to have
the parentheses use all the time.  Maybe I need to say that better?

> Options are:
> 
> sizeof c
> sizeof(c)
> 
> or
> 
> sizeof (c)
> 
> If you take sizeof the type rather than the variable, the options are
> 
> sizeof(int)
> 
> or
> 
> sizeof (int)
> 
> [snip]
> 
> 
> Regards: David Weinehall


-- 
~Randy
