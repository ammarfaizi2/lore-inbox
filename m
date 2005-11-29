Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVK2TW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVK2TW1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK2TW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:22:27 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:49216 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbVK2TW0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:22:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HtVrvn7eavrec4T61d9fx/z0xHubn8unYbE/iOOw2QvtAwmLQF2/MNsmvGt1KQuUhhGYmZNSgyGR4CO1sCi+q0xjPpIJNQcvv2KqoNCOAPgf/gm15oz75JV0BdKBjxudyKJNdm57dNkneprX3dykQlxeseAEF2KBnug0q9e1XTM=
Message-ID: <a762e240511291122x5551b129i94ee46d9f10548d2@mail.gmail.com>
Date: Tue, 29 Nov 2005 11:22:26 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: "0602@eq.cz" <0602@eq.cz>
Subject: Re: totally random "VFS: Cannot open root device"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <438B6E05.8070009@eq.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <438B6E05.8070009@eq.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What SATA controler are you using in your box? What does lspci report?
It sounds to me like the driver you are using is not playing well with your
SATA controler or drive.  It could be related to crappy HW or a driver issue.

When you system boots the drive says online and behaves ok?  You just
see device trouble when you boot up correct?

Is it possible to capture the boot messages from a failed boot (serial console,
netconsole)?  It can tell alot about why no root fs was found.  Most likley
no disk were found by the SATA driver.

Thanks,

Keith
