Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVA1VNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVA1VNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVA1VJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:09:38 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:25555 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262801AbVA1VGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:06:41 -0500
Message-ID: <41FAA945.3070106@mnsu.edu>
Date: Fri, 28 Jan 2005 15:06:13 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>, kruty@fi.muni.cz
Subject: Re: journaled filesystems -- known instability; Was:	XFS:	inode	with
 st_mode == 0
References: <20041209125918.GO9994@fi.muni.cz>	 <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>	 <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>	 <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>	 <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org>	 <20050117100746.GI347@unthought.net>  <41EC2ECF.6010701@mnsu.edu>	 <1106657254.1985.294.camel@sisko.sctweedie.blueyonder.co.uk>	 <41F6613F.6030509@mnsu.edu>	 <1106667472.1985.644.camel@sisko.sctweedie.blueyonder.co.uk>	 <41FA9D72.2080303@mnsu.edu> <1106946002.1988.88.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1106946002.1988.88.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>Hi,
>
>On Fri, 2005-01-28 at 20:15, Jeffrey E. Hundstad wrote:
>
>  
>
>>>>Does linux-2.6.11-rc2 have both the linux-2.6.10-ac10 fix and the xattr 
>>>>problem fixed?
>>>>        
>>>>
>
>  
>
>>>Not sure about how much of -ac went in, but it has the xattr fix.
>>>      
>>>
>
>  
>
>>I've had my machine that would crash daily if not hourly stay up for 10 
>>days now.  This is with the linux-2.6.10-ac10 kernel. 
>>    
>>
>
>Good to know.  Are you using xattrs extensively (eg. for ACLs, SELinux
>or Samba 4)?
>
>--Stephen
>
>  
>
On the machines that were having problems we really weren't using them 
for anything.  I think I may have been running into the BIO problem that 
was fixed in 2.6.10-ac10.


