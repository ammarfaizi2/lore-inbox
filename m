Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQKPA7b>; Wed, 15 Nov 2000 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129371AbQKPA7V>; Wed, 15 Nov 2000 19:59:21 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:33809 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129255AbQKPA7R>;
	Wed, 15 Nov 2000 19:59:17 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011160029.eAG0T9i439695@saturn.cs.uml.edu>
Subject: Re: test11-pre5 breaks vmware
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 15 Nov 2000 19:29:09 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8uuqmv$el4$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 15, 2000 12:12:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Actually, I know of at least one other shipping commercial
>> product (Sitraka's JProbe Java Profiler) that will require
>> patching because of this change.  It seems unwise to be
>> changing field names in commonly used /proc files like
>> cpuinfo at this point in time. 
>
> The problem with "flags" is that it no longer contains quite
> the same information.  Since the semantics of the field changed
> slightly, changing the field name is sometimes more correct.

The data sure looks like flags to me. If "flags" referred
to some specific Intel register, it could be just hex.
Anyway, breaking apps to make /proc pretty is just bad.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
