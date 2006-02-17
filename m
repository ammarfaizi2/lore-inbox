Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWBQPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWBQPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWBQPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:41:59 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:11925 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751477AbWBQPl7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:41:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sfoO5w+C2F0xr8jn0PIwVa0O5hH+eG6ll0XdUU9RbiPeZ74Yuk2sWSBER83iXzBpc/gftjg8FrttA3NEL1kgAv0nwh3D0TbWO+wD9PfrumSjDdAFrZykn7+09XMHTc7B0bVE6lXcX+1hQjasyDNGDQQ+PDGohcp6MWtYIjfsG+E=
Message-ID: <a36005b50602170741n620d51a4m4cb1346ddc9d3efb@mail.gmail.com>
Date: Fri, 17 Feb 2006 07:41:58 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: glibc side of the robust mutex patch
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who need to see the glibc side of the robust futex patch to
make up their minds, it is available for now at:

http://people.redhat.com/drepper/d-robust-list

It must be applied on top of the current cvs code and it's only
working on x86 and x86-64 so far (maybe SH).  There is one unfortunate
area in the patch which makes it look ugly (the list handling on
64-bit systems, due to the layout requirements and the kernel list
walking) but the rest is easy and clean.
