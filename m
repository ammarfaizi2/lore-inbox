Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbWGGBFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWGGBFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 21:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWGGBFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 21:05:43 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:55931 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751122AbWGGBFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 21:05:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=RSBxCe/PwMFuvf530N8aqhzCH8p+Aa4z5QOH9FNLMZryvY6dP9gr1+iXr7jDPG3kQL87oFZ+a5YnIUJbb/ClWviRoFob3pv5i+RJZoEKrY+pXgYAzgOjhaWWCVAAwtlwUrjXr918TJc8uowl4xawdCCr962wNY4DjAbKFpizW5o=
Message-ID: <4413284c0607061805l66cd270fqff2094d5eeda9131@mail.gmail.com>
Date: Thu, 6 Jul 2006 22:05:42 -0300
From: "=?UTF-8?Q?Herv=C3=A9_Fache?=" <Herve@lucidia.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1
In-Reply-To: <44AD680B.9090603@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <44AD680B.9090603@unsolicited.net>
X-Google-Sender-Auth: 02606a078f2c19c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is your prompt different? # first, then >. Could it be that your
system thought you were root in the second case? Just a stupid
thought...

On 7/6/06, David R <david@unsolicited.net> wrote:
> Linus Torvalds wrote:
> > Ok,
> >  the merge window for 2.6.18 is closed, and -rc1 is out there (git trees
>
> Most things seem fine here with rc1, but I do see a permissions issue with my
> USB scanner.
>
> In 2.6.17
>
> david@davidux:/dev/bus/usb/001 # l
> total 0
> drwxr-xr-x 2 root  root    100 2006-07-06 20:19 ./
> drwxr-xr-x 4 root  root     80 2006-07-06 20:19 ../
> crw-r--r-- 1 root  root 189, 0 2006-07-06 20:19 001
> crw-r--r-- 1 david root 189, 1 2006-07-06 20:19 002
> crw-r--r-- 1 root  root 189, 4 2006-07-06 20:19 005
>
> but with 2.6.18
>
> david@davidux:/dev/bus/usb/001> l
> total 0
> drwxr-xr-x 2 root root    100 2006-07-06 20:24 ./
> drwxr-xr-x 4 root root     80 2006-07-06 20:24 ../
> crw-r--r-- 1 root root 189, 0 2006-07-06 20:24 001
> crw-r--r-- 1 root root 189, 1 2006-07-06 20:24 002
> crw-r--r-- 1 root root 189, 4 2006-07-06 20:24 005
>
> Does something need tweaking with udev scripts maybe? This is a SuSE 10.1 system.
>
> Cheers
> David
>
>
>
>


-- 
In a world without walls and fences, who needs Windows and Gates?
