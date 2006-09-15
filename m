Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWIOKCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWIOKCI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWIOKCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:02:08 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16805 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750814AbWIOKCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:02:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lIh57zMvyk6G5ax+yJMw64wPiVeSTUL6He+jDBa7yZ3/vRios/AvCQJZZULbq1qlaFB5tK2wPBWHKs7OTnFOXL5FoKCgc65c6bIexCUIRvtHm877wAO3NSFyWwBq/r1gdDARhp3/MHXz4Xc9DOdXVq7l/a2cg84wgN/9a5fmawg=
Message-ID: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com>
Date: Fri, 15 Sep 2006 15:32:06 +0530
From: "Madhav Bhamidipati" <madhavb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on compiling a kernel Module
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have the following source tree, objective is to get a single kernel
module.ko object.


module/
module/sub-module1
module/sub-module2
module/include
module/objs/


module folder has a Makefile, it may or may not have *.c files, it
invokes sub-* Makefiles
which build respective objects, these objects need to go into objs
folder, finally makefile in 'objs'
builds the module.ko linking all sub-module *.o.

I could not find much information for my requirement in the file
linux/Documentation/kbuild/makefiles.txt

any information with an example for my requirement is greatly
appreciated. Also let me know
how do I expose module/include in sub-module/ c files, looks like
-I../include is not working

-Madhav
