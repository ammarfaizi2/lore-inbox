Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWH0TWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWH0TWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWH0TWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 15:22:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:10637 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932188AbWH0TWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 15:22:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PhxJ8NSDI1AJ/H9vNSxl+D3OlorRj1/KFW0/y6b+El4HmkvizeriFrszQQyjt/ixlo2zn6cpyHsR0juiUQuogEDxGz7AlBNqI4JYVdop/qXaMJHB/s1rv3Lp3awlVqj6dKMruexBunRsu1zkvu7JS+1+1nm5SSvXC4zO9dcIAvs=
Message-ID: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
Date: Mon, 28 Aug 2006 03:22:15 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: ak@suse.de, "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>
Subject: Why Semaphore Hardware-Dependent?
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't we have a hardware-independent semaphore definition while we
have already had hardware-dependent spinlock, rwlock, and rcu lock? It
seems the semaphore definitions classified into two major categories.
The main deference is whether there is a member variable _sleeper_.
Does this (optional) member indicate any hardware family gene?

Best Regards.
Feng,Dong
