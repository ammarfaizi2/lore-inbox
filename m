Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUBNIam (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUBNIam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:30:42 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:58857 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S261262AbUBNIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:30:37 -0500
Message-ID: <402DDD4E.6020204@quark.didntduck.org>
Date: Sat, 14 Feb 2004 03:33:18 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ameer armaly <ameer@charter.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel boot order
References: <Pine.LNX.4.58.0402132237320.14412@debian>
In-Reply-To: <Pine.LNX.4.58.0402132237320.14412@debian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ameer armaly wrote:
> Hi all.
> What determines the order in which parts of the kernel are loaded?  Is it
> in main.c or omsething like that or is it in the link order, or something
> totally different.
> Please reply privately to me at ameer@charter.net since I can't handle 300
> msgs a day.
> Thanks,
> 

Unless it's explicity called from init/main.c, then it's initcall level 
then link order that determines the order.

--
				Brian Gerst
