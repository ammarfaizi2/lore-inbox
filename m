Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965685AbWKHMxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965685AbWKHMxf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbWKHMxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:53:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:20449 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965685AbWKHMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:53:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i6ZMsZCZCHvr+tHGta1KhSkk+81r7+LKyVOe+29v/jnEy/QskjJXz9scUOQXIJ0Ng83HUlRB+Fg3LUjHw18052FXKJQdFiI1WiTDVlYtKrkRUK8Gu/w/N8+zgwXCqEt71KLhZy2hBxjanjmPw5UFltwSi7xX+pdn4v+a/+wUstk=
Message-ID: <f36b08ee0611080453p5401de04td2fef8bff4d0efb3@mail.gmail.com>
Date: Wed, 8 Nov 2006 14:53:34 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: invalidate/drop filesystem caches & io buffers
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to invalidate/free the filesystem caches and io buffer cache
How can I do this when I can't unmount the filesystem (and w/o reboot) ?

(I run filesystem I/O test that needs to  start from fresh  cache &
buffer state -- as emty as possible, like right after mount/boot).

I tried  'mount -o remount' but it didn't make any difference
on the timing. Apparently 'mount -o remount' did not invalidate
cases/buffers ? ( The difference between fresh run vs non-fresh
run timing is x5 times ).

Thanks
Yakov
