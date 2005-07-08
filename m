Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVGHKO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVGHKO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVGHKO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:14:57 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:39450 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261247AbVGHKO5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:14:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F/7P2e8iMZffdLxeTdM8bi/qyuIR2pnSbjPQoU7LOYSo6uAH2UJ06DmidYiAVyT/jh1huruFRCUk9PCl0haHOGUehBRQtSQAzt1W7tcBWiX+qHM7KakGazrHT4DSQV0obz8tMQq4TBVR3J43O0ER+F+e+WGetQmUtAcDZN1Za7M=
Message-ID: <4fec73ca05070803144da4b3c1@mail.gmail.com>
Date: Fri, 8 Jul 2005 12:14:56 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Reply-To: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Developing a filesystem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I anounced a couple of weeks ago, I'm studying how to build a new
filesystem. I have taken a look at the ramfs and also read some
documentation about.

Now I'm writing my own dummyfs (based on ramfs) to know how this
works, but I'm having problems compiling it; I need to include the
"linux/fs.h" header file to have access to some structures definitions
(such as struct file_system_type), but this is giving me some errors.
So I think that I have to integrate my code with the kernel sources to
make it compile.

Therefore, my question is, is there any way to check wheter my code
compiles or not without having to integrate it with the kernel code?
If not, is there any tutorial to learn how to integrate a filesystem
into the Linux kernel code?

Thanks you,

-- 
Guillermo
