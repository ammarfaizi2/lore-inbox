Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWDGGkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWDGGkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDGGkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:40:40 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:47288 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932314AbWDGGkj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:40:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AeyM1FgDfGh8ECYkBkIfgnlFvm+Nb6u/XWue+8/OljAflbnA6dQDDjVz0w+x/NL2NQCDlzMxJAWiuzYYiRx+S/KxpzQ/xxSDwpLpRgzARYbbA9uD1KhXfxEcyfcMFiNH54iyj+AZikI8Ddf+1mlpPmtlvBlvYtji05KUR5u5FqM=
Message-ID: <8bf247760604062340m7b83f0bbpe90a9222709a3a5e@mail.gmail.com>
Date: Thu, 6 Apr 2006 23:40:38 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Preprocessing output of kernel sources
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
What is the best way to let C preprocessor to parse all the
kernel source files to resolve #ifdef's after I have configured the
kernel?

There are many Makefiles in the sources, I dont want to modify each one of them.


Indiviually files i can do cc -E.


I would like to have the preproccessed output to be stored in
the format filename.X

ie each file compile must have a filename.X
This would be useful. am not sure how to do it.


I know it has something to do with shell programming. But i feel this
is the right place to ask because some of you might have done this
before.



Any help will be highly appreciated.

thanks and regards,
sriram
