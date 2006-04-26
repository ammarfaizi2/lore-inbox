Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWDZPCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWDZPCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWDZPCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:02:15 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:9361 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932455AbWDZPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:02:14 -0400
Date: Wed, 26 Apr 2006 11:02:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: can't compile kernels lately (2.6.16.5 and up)
In-reply-to: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200604261102.12935.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 09:39, Grzegorz Jaśkiewicz wrote:
>root@puppet:/usr/src/linux-2.6.16.11# make
>  CHK     include/linux/version.h
>  HOSTCC  scripts/mod/file2alias.o
>scripts/mod/file2alias.c:386: warning: 'struct input_device_id'
>declared inside parameter list
>scripts/mod/file2alias.c:386: warning: its scope is only this
>definition or declaration, which is probably not what you want
>scripts/mod/file2alias.c: In function 'do_input_entry':
>scripts/mod/file2alias.c:390: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:390: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:390: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:390: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:390: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:391: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:391: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:391: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:391: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:391: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:392: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:392: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:392: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:392: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:392: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:394: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:394: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:394: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:394: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:394: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:398: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:399: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:401: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:402: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:404: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:405: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:407: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:408: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:410: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:411: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:413: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:414: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:416: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:417: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:419: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c:420: error:
> dereferencing pointer to incomplete type
> scripts/mod/file2alias.c:422: error: dereferencing pointer to
> incomplete type scripts/mod/file2alias.c:423: error: dereferencing
> pointer to incomplete type scripts/mod/file2alias.c: In function
> 'handle_moddevtable':
>scripts/mod/file2alias.c:515: error: invalid application of 'sizeof'
>to incomplete type 'struct input_device_id'
>make[2]: *** [scripts/mod/file2alias.o] Error 1
>make[1]: *** [scripts/mod] Error 2
>make: *** [scripts] Error 2
>
>
>any hints ? I can see that file2alias.c is using kernel-only includes,
>there might be something missing to make it work (this is a hack, and
>you know it :P)

This has a slight taste of a bzip2 error.  As I'm instantly running 
2.6.16.9, and have .11 ready for a reboot, I've not encountered any 
such with my compiles here, but after having been burnt a couple of 
times, I now get the .gz files to src the stuff and have not had that 
sort of thing happen since.  YMMV of course, but its one suggestion of 
something to try.
 
>--
>GJ
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
