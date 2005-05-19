Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVESRCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVESRCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVESRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:02:33 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:33078 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261155AbVESRC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fg4tAoPhbehMQUiLUuZoEzQuZHIPYo2PwxqMA9/sJjwbFhr6x71Q3KbMuA7ijdMKaRy7BbsBytUySIOHaFnPSBORmKxkYqqv5h7FYp4LInwClWX/wOachWtuUO0aMzZK6vOgf/9YcxDHzq6b329hH/tz61Wx4UrPN1yUAtEMdVk=
Message-ID: <90f56e480505191002197d3ac@mail.gmail.com>
Date: Thu, 19 May 2005 10:02:27 -0700
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: John Clark <jclark@metricsystems.com>
Subject: Re: GDB, pthreads, and kernel threads
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <428CBD63.8020704@metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it>
	 <45zKO-3RV-45@gated-at.bofh.it> <428BDA56.5030502@shaw.ca>
	 <428CBD63.8020704@metricsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, I do believe I'm using the NPTL package for threads. Is there a
> way to absolutely tell without
> question?

If you run /lib/libc-{version}.so your output will show you what are
you running.

For example:

$/lib/libc-2.3.2.so
GNU C Library stable release version 2.3.2, by Roland McGrath et al.
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 3.2.3 20030502 (Red Hat Linux 3.2.3-20).
Compiled on a Linux 2.4.20 system on 2003-10-02.
Available extensions:
        GNU libio by Per Bothner
        crypt add-on version 2.1 by Michael Glad and others
        linuxthreads-0.10 by Xavier Leroy 
-------------------------------->linuxthreads
        The C stubs add-on version 2.1.2.
        BIND-8.2.3-T5B
        NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
        Glibc-2.0 compatibility add-on by Cristian Gafton
        libthread_db work sponsored by Alpha Processor Inc


Thanks
Ajay
