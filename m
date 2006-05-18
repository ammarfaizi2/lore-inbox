Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWERPDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWERPDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWERPDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:03:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:27203 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751225AbWERPDY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:03:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ii1oLpy52XqR9UL36h4UxJxV6uZyHLDuH4tnZg96CFOMUtipokMQtiBj5xoYUcVa0v4DYbWyAY2py7BElvwhZvb9fqBeKgZtIIkQNPKx2Vk5oplDGy/s+UirxYWbhQMYbKe7oS479jgSub0OitrBK68IrZS/ajCxfbEfuQC0sRc=
Message-ID: <6278d2220605180756s30c08a6en543531c18556bf63@mail.gmail.com>
Date: Thu, 18 May 2006 15:56:35 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: USB keyboard driver buggy, repeats keys
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was having a similar (but unrelated) problem with the certain
revision of the popular compaq/hp black+silver PS/2 keyboards.

To reproduce it, hold down the right shift key and tap Q then S in
pretty quick succession - the S is dropped. There are quite a few
other combinations where the second letter is dropped. The second
letter is not dropped when the left shift key is used.

It turns out the problem was local to the keyboard and a newer
revision (branded hp, rather than compaq) worked fine.

felix-linuxkernel@fefe.de wrote:
> I bought a USB keyboard recently, and I am a fast typist.
>
> When I type "incoming" in a hurry, I press i, then n, then c, and
> then I release i, then n, then c.  When I do this, Linux registers these
> keystrokes:
>
>   incin
>
> I first thought this is a bug in my keyboard, so I tried the same thing
> on Windows -- I get "inc", just as expected.
>
> Please fix!
>
> Felix
-- 
Daniel J Blueman
