Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVHFK0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVHFK0q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 06:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVHFK0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 06:26:46 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:21344 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261207AbVHFK0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 06:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RKkBVaBJQ3n2ON52oB2Q+F9hAoxW3sgMSaYC3GduwU14VwAE2K10UjF9N1UGQKsUAWLrcde4s8omsVFYa2cnpUDkAM5O6xWP7MRm6dDe6ePb7qVJA2VdbOzQ8Kj++5q3xsW2sEx0vuQS5JkV86WdHoB2Vrplp6Qu8W77nXlaZPs=
Message-ID: <42F49037.9030206@gmail.com>
Date: Sat, 06 Aug 2005 12:25:59 +0200
From: Henrik Kretzschmar <trash4henni@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Any access control mechanism that allow exceptions?
References: <4ae3c1405080600082ef440c8@mail.gmail.com>
In-Reply-To: <4ae3c1405080600082ef440c8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> Hi,
> 
> I want to lock down a directory to be read-only, say, /etc, for system
> security. Unfortunately, some valid system tools might need to
> create/modified files like "/etc/dhclient-eth0.conf".  To avoid
> disrupting the normal running of those tools, I might have to allow
> certain files to be created under /etc.
> 
> Is there any way that allows me to specify what files are allowed to
> be created while locking down the whole directory at most of the time?
> 
> I think of adding an exception list as extend attributes of Ext3
> filesystem, and changes the Ext3 filesystem to enforce the policy. But
> this method looks awful.
> 
> Any elegant way to achieve this goal? 
> 
> Thanks
> 
> xin

What about symbolic links to a writable directory?

Henni
