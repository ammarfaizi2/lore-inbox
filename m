Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbULQCXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbULQCXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 21:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbULQCXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 21:23:24 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:6022 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S262723AbULQCXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 21:23:13 -0500
Message-ID: <41C2433E.4040402@metaparadigm.com>
Date: Fri, 17 Dec 2004 10:23:58 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: automated filesystem testing for multiple Linux fs
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com> <41BDE2CF.9060402@austin.rr.com> <20041216121151.GH8246@logos.cnet> <1103215183.12201.39.camel@smfhome.smfdom> <41C2280C.1030009@metaparadigm.com> <41C22D93.3030101@austin.rr.com>
In-Reply-To: <41C22D93.3030101@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:

> Michael Clark wrote:
>
>> Steve French wrote:
>>
>>> ...  Since
>>> at present only XFS and JFS have the full combination of server
>>> features: better quotas, DMAPI, xattr support, ACL support and
>>> nanosecond file timestamps on disk
>>>
>>
>> Does JFS have quota support now?
>>
>> Last I looked it was still on the To Do list.
>>
>> ~mc
>>
> I remember them adding it four months ago or so.  Looking at 
> http://linux.bkbits.net/linux-2.5
> it seems to be mostly in changeset 1.1803.133.1


Oh, that's good news. This was one reason you couldn't really consider 
using JFS on a /home fileserver (which sort of implies quotas). It 
perhaps it needs a lot of testing as it's quite new. Any experiences? 
(ie. survives a highly parallel load from a lot of threads with 
different uids).

~mc
