Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946674AbWKAHvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946674AbWKAHvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946678AbWKAHvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:51:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:10902 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946674AbWKAHvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:51:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KCU+HOCWqWkJFAKB3gSp5z/5vMR5MND9QeXa9BPN1zY3ImRW0d206gB6p760fkJY3TzgmCpqKT962uydadOUs2jRzdMa/QUtEALX6haikgHtlfv6SdqgkUEhY9Htwgy0PjgcoUYO0RcmKR8MnFM5BFV7yQ5ZbgclGzPfapXwHlI=
Message-ID: <6d6a94c50610312351g46224cdbr20f5640689ec7109@mail.gmail.com>
Date: Wed, 1 Nov 2006 15:51:01 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to add a device file to sysfs?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When a misc device file is registered, there are two files under my
own class directory:

/sys --> class --> misc --> myprog --> dev
                                                  --> uevent
                                                  --> myprog_show (to be added)

Now, my question is, is it possbile to add the third file
"myprog_show" under "myprog" directory without modify any common code?

I've read the doc under linux-2.6.x/Documentation, I can add it to
some other directory under /sys, but not found a way to add it to my own
directory.

Thanks for any help.
-Aubrey
