Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965798AbWKEDBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965798AbWKEDBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965799AbWKEDBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:01:09 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:45179 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965798AbWKEDBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:01:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uGaMxNHsIV60X5/8u914MUA3oc0AGCMt0Mxlxz+o1EB7CidMRXdtaWetHxeEOGmyNqtf9OjdehLeSS9fdpw5toEgNrVGQfucHew7LO9jgpeLLKT0gsOjLHTFeZjXPSJP32Ol9OYhvCqt4+3+J4Y8yK5JqBNDntOay7iWzF6HkTo=
Message-ID: <7797aa370611041901k5bc82055q9477521b0f2eca34@mail.gmail.com>
Date: Sun, 5 Nov 2006 11:01:04 +0800
From: "Chuanwen Wu" <wcw8410@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to change my fs's magic number?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,everybody!

I am learning how to add my file system.
Now ,i have add my fs called "myext2" with the magic number 0x6666
(" #define MYEXT2_SUPER_MAGIC      0x6666" in the file
include/linux/myext2_fs.h)to the kernel .
Myext2 is similar with ext2 but the name.
And i compiled kernel successfully.
And then i created my "myfs" in the type myext2

#dd if=/dev/zero of=myfs bs=1M count=1
#mkfs.ext2 myfs

The problem is after "#mkfs.ext2 myfs" ,how i can change myfs's magic
number to 0x6666 but not 0xEF53 which is used by ext2?

Thanks in advanced!
-- 
wcw
