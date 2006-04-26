Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWDZNj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWDZNj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWDZNj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:39:58 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:51928 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932431AbWDZNj6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:39:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iXz7L4IvCwHo4gT9T9a3DvY5TSQhLMxJDcwGQlGvKT4bfTiLJRckjsijU1gBu7ewzbf7grytX0M+GUlvBPd2ff3Udy4EPhNryYmOUUQCjuibYbu8rJ+CLRvvK9MkZStDvI11iBPawCWgfb/buNL3ULrGywsnsjYktVYeM9DXuFs=
Message-ID: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
Date: Wed, 26 Apr 2006 15:39:57 +0200
From: "=?ISO-8859-2?Q?Grzegorz_Ja=B6kiewicz?=" <gryzman@gmail.com>
To: "Kernel development list" <linux-kernel@vger.kernel.org>
Subject: can't compile kernels lately (2.6.16.5 and up)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@puppet:/usr/src/linux-2.6.16.11# make
  CHK     include/linux/version.h
  HOSTCC  scripts/mod/file2alias.o
scripts/mod/file2alias.c:386: warning: 'struct input_device_id'
declared inside parameter list
scripts/mod/file2alias.c:386: warning: its scope is only this
definition or declaration, which is probably not what you want
scripts/mod/file2alias.c: In function 'do_input_entry':
scripts/mod/file2alias.c:390: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:390: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:390: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:390: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:390: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:391: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:391: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:391: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:391: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:391: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:392: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:392: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:392: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:392: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:392: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:394: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:394: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:394: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:394: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:394: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:398: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:399: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:401: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:402: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:404: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:405: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:407: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:408: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:410: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:411: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:413: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:414: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:416: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:417: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:419: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:420: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:422: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c:423: error: dereferencing pointer to incomplete type
scripts/mod/file2alias.c: In function 'handle_moddevtable':
scripts/mod/file2alias.c:515: error: invalid application of 'sizeof'
to incomplete type 'struct input_device_id'
make[2]: *** [scripts/mod/file2alias.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2


any hints ? I can see that file2alias.c is using kernel-only includes,
there might be something missing to make it work (this is a hack, and
you know it :P)
--
GJ
