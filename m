Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWC3FwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWC3FwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWC3FwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:52:06 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:33915 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750979AbWC3FwF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:52:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mWduL1aCl/kGgsSfUHZOYV7xiy1O3JuQHQC/0sz6FYn4ic7nKwlJOl76IVc7ZdoAMXeenV59Cnjw0B3mZMmNCNg94q9QwvRo3AKKLlU0sln6EKxYDbYo1XddP3Tkh+ief82gcFOU/+Zi8vX7oS63wqkxrVuq/A6dDfdA1t3/dLk=
Message-ID: <60bb95410603292152l7597259dx28eaec77ebc5dfdf@mail.gmail.com>
Date: Thu, 30 Mar 2006 13:52:04 +0800
From: "James Yu" <cyu021@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: jiffies doesn't increase while doing mdelay() ?
In-Reply-To: <60bb95410603292150r6448596clbef348e1bededdaf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <60bb95410603292150r6448596clbef348e1bededdaf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am doing the following in a kernel thread :

===== code segment=====
prink("before mdelay:%d, ", jiffies);
mdelay(300); // delay 300ms
printk("after mdelay:%d\n", jiffies);
===== code segment=====

However, jiffies before and after doing mdelay are the same!!!
Can someone please explain why jiffies doesn't change ?

Cheers,
--
James
cyu021@gmail.com
