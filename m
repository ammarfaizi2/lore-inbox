Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWFYLoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWFYLoV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWFYLoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:44:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:65456 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932385AbWFYLoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:44:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QhZUVyO/Ad/Y1RKwRn4JpkR9TaMJ1NBcgJx+zB7P0Qtxz4jjNAgftuaXcJ0DiVQlpL1YViZVL+I1snSyLQ3b9oiN1TRiqVy7/YAdwlGRGbOd5lGkN9+pWFQmumVJDvFJLi0NaCvHWaK0KlFhjmUEMT1PDKmoTNOYiH1Gj67r1yk=
Message-ID: <449E770E.4010102@gmail.com>
Date: Sun, 25 Jun 2006 20:44:14 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and Power Management
 patches against v2.6.17
References: <20060625073003.GA21435@htj.dyndns.org> <449E73C1.4050604@tomt.net>
In-Reply-To: <449E73C1.4050604@tomt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Tejun Heo wrote:
>> Hello, all.
>>
>> libata-tj-stable patches against v2.6.17 and v2.6.17.1 are available.
> 
> It appears drivers/scsi/libata-eh.c isn't getting built in the 2.6.17 
> patch, seems to be missing in drivers/scsi/Makefile:

Yeap, right.  My bad.  I forgot to do 'quilt add' the Makefile.  The 
updated tarball is at

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625-1.tar.bz2

Sorry about the trouble.

-- 
tejun
