Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbVLOIkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbVLOIkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422633AbVLOIka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:40:30 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:1581 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422631AbVLOIka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:40:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eaguQ+F4yQeVNk3Fq5u29dh8z90Wa+Bk3mSbitjdqP4wapYsTMQp5Eg52yLhJhIIMVQI2VN2kGXtGh/i9kWJunUzpIJR7zpHqHTeKTMyExsH6e5UZxm28GU/+TmWbFSFI4Qbs3jL3pd04M4IH3ET/rUzFyQuy4RA5/Yxq6ELFN0=
Message-ID: <a44ae5cd0512150040m59e75e9fp1f80eb5ff124e1f0@mail.gmail.com>
Date: Thu, 15 Dec 2005 00:40:29 -0800
From: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
In-Reply-To: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, I did enable the new kernel size optimization.
My gcc info is:

Target: i486-linux-gnu
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr
--enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --enable-nls
--program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-awt=gtk-default
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-werror --with-tune=pentium4
--enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.3 20051204 (prerelease) (Ubuntu 4.0.2-5ubuntu2)

Should this be okay?

I hope this helps,
          Miles
