Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWHVQlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWHVQlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWHVQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:41:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38472 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751410AbWHVQll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:41:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gQ7Wm/abBRL9HmvIzTNyUuUQgRMDx96o2DWSzb3FPrAIOdTQpAz3ux8Q4m3U9jhX/JPO9EFWKlY/IZ6hg83j/6/G+qbX8bvtGVf32FX7yfAVWuhawXyi60wotCZlDyHLms5yWt0Q8Hd2wdjoYfca0FgsRTST3D7nhmKyJszR5rw=
Date: Tue, 22 Aug 2006 20:50:53 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Message-Id: <20060822205053.37472ba7.pauldrynoff@gmail.com>
In-Reply-To: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several attempts of booting I got similar, but not the same message:
all things are similar like
last sysfs file: /block/hda/range
eip, and other registers, but
process not init:
Process htplug (pid: 942, ti=c7424000 task=c7420590 task.ti=c7424000)

Also, I should say that I can reproduce problem on real machine, and on qemu.
