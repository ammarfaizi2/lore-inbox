Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289792AbSAQQ1m>; Thu, 17 Jan 2002 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSAQQ1c>; Thu, 17 Jan 2002 11:27:32 -0500
Received: from f96.law11.hotmail.com ([64.4.17.96]:51726 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S289792AbSAQQ1X>;
	Thu, 17 Jan 2002 11:27:23 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
Date: Thu, 17 Jan 2002 08:27:17 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F96rPJjUsZ6G7KCk5sm0001ad67@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2002 16:27:17.0581 (UTC) FILETIME=[D45A07D0:01C19F73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I was trying to state is that the protocol specific
code does not get to see the length passed from the user.
The protocol specific code would like to look at what
the user passed.

Balbir

>You totally missed what move_addr_to_user() does, which is in fact
>truncate the copied len to what the user supplied.  Also, the comments
>in move_addr_to_user even quote the bits of 1003.1g you a referring
>to.
>
>In short, the bug you suggest is not there.




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

