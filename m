Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUGEUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUGEUlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUGEUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:41:36 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:5004 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262213AbUGEUlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:41:24 -0400
Message-ID: <40E9BD29.5040708@blue-labs.org>
Date: Mon, 05 Jul 2004 16:42:17 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040705
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: segfaults and sockets
References: <40E9B8D0.10508@blue-labs.org> <20040705133230.7439d301.davem@redhat.com>
In-Reply-To: <20040705133230.7439d301.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010204020104060704060700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204020104060704060700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thank you, I've forwarded/reported the bug.

David S. Miller wrote:

>On Mon, 05 Jul 2004 16:23:44 -0400
>David Ford <david+challenge-response@blue-labs.org> wrote:
>
>
>  
>
>>ioctl(5, 0x8906, 0x7fbfffeff0)          = 0
>>--- SIGSEGV (Segmentation fault) @ 0 (0) ---
>>+++ killed by SIGSEGV +++
>>    
>>
>
>0x8906 is SIOCGSTAMP, aparently the app isn't using a large enough
>structure to capture the timestamp, and the kernel is thus overwriting
>some critical part of the stack causing it to crash.
>  
>

--------------010204020104060704060700
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------010204020104060704060700--
