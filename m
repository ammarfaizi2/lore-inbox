Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVI2VXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVI2VXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVI2VXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:23:07 -0400
Received: from citi.umich.edu ([141.211.133.111]:2177 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751334AbVI2VXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:23:06 -0400
Message-ID: <433C5B34.9060907@citi.umich.edu>
Date: Thu, 29 Sep 2005 17:23:00 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Network Appliance, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com> <433C4B6D.6030701@pobox.com>
In-Reply-To: <433C4B6D.6030701@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------080704090108050103010306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704090108050103010306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Dave Jones wrote:
> 
>> You wrote..
>>
>> $ git clone 
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
>> linux-2.6
>> $ cd linux-2.6
>> $ rsync -a --verbose --stats --progress \
>>   
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
>> \
>>   .git/
>>
>> Could be just..
>>
>> $ git clone 
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
>> linux-2.6
>> $ cd linux-2.6
>> $ git pull
>>
>> Likewise, in the next section, git pull doesn't need an argument
>> if pulling from the repo it cloned.
> 
> 
> 
> Nope.  It intentionally includes the manual rsync because clone/pull 
> doesn't seem to grab tags.  Or at least last time I checked...

i just used the instructions at the bottom of your web page to grab new 
tags, and it completely wiped all my Stacked Git metadata.  (fortunately 
i was trying this in a test repository, and it will be simple to recover 
the missing files).

so, this is probably something that should have a warning, or maybe you 
might consider providing an example that won't wipe out existing files 
and directories under .git/ ...

--------------080704090108050103010306
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------080704090108050103010306--
