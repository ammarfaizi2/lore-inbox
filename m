Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276803AbRJBXzb>; Tue, 2 Oct 2001 19:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276799AbRJBXzW>; Tue, 2 Oct 2001 19:55:22 -0400
Received: from james.kalifornia.com ([208.179.59.2]:15657 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S276798AbRJBXzH>; Tue, 2 Oct 2001 19:55:07 -0400
Message-ID: <3BBA53ED.90404@blue-labs.org>
Date: Tue, 02 Oct 2001 19:55:25 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010929
X-Accept-Language: en-us
MIME-Version: 1.0
To: Petr Titera <Petr.Titera@quick.cz>
CC: haiquy@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: linux kernel 2.4.10 possibly breaks LILO
In-Reply-To: <002c01c14b6b$5f19ba30$13a76cc0@NEVSKIJ>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lilo is fine, back down to the kernel image prior to your current one, 
run lilo with your new image, then boot into the new image.

Lilo can now be run just fine.

Something in the pre10 series hosed something which caused the first 
instance of lilo to segfault then the next to deadlock waiting on a 
page.  2.4.10 proper fixed that.  In my case I reverted to 2.4.7-pre6, 
ran lilo, then booted into 2.4.10 and ran lilo.  Worked like a charm. 
 ('course I had a boot disk at the ready)

David

Petr Titera wrote:

>Possitive here. Just try to change to new kernel image. I was forced to
>install grub after upgrading to 2.4.10.
>


