Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSJWWZx>; Wed, 23 Oct 2002 18:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSJWWZx>; Wed, 23 Oct 2002 18:25:53 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:51171 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265270AbSJWWZw>; Wed, 23 Oct 2002 18:25:52 -0400
Message-ID: <3DB723A7.6060400@si.rr.com>
Date: Wed, 23 Oct 2002 18:33:11 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44-ac1 : init/do_mounts.c
References: <200210232214.g9NMEXR05530@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,
     lib/inflate.c has a patch as well to remove STATIC.
Regards,
Frank

James Bottomley wrote:
>>  This patch removes an outdated macro STATIC.
> 
> 
> I don't think you want to do this. The definition STATIC alters the behaviour 
> of the #included "lib/inflate.c" which is used for uncompressing ramdisks.  I 
> think you'll find do_mounts.c may not even compile with it undefined since it 
> will now look for a missing "gzip.h" header.
> 
> James
> 
> 
> 
> 


