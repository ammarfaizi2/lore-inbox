Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWEIF2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWEIF2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWEIF2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:28:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:42848 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751386AbWEIF2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:28:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:x-mimeole:in-reply-to:thread-index;
        b=ptmp7vrj2uCsRCeg6KexUQ5ueV70lYwe80iVcB+hY6a8unR021aQJ+JXiJf85/eCvmSVcjx8fafU7QN3iINzgJTjK7XPLkwGEI6DeN2zn/Licj5Oe+A4KJU0rgj+C7tGvKokHMXS+uM0tOCqA80YsKIt1kYBYlP0N4abNyifXSE=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Arjan van de Ven'" <arjan@infradead.org>
Cc: "'Erik Mouw'" <erik@harddisk-recovery.com>,
       "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Jason Schoonover'" <jasons@pioneer-pra.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: High load average on disk I/O on 2.6.17-rc3
Date: Mon, 8 May 2006 22:27:52 -0700
Message-ID: <005301c67329$52b5fe30$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <44601E9C.2010802@yahoo.com.au>
Thread-index: AcZzJxKf4UjKgWgRSGCUEf+iHXm+KgAAf+qg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A global loadavg isn't too good anyway, as everyone has 
> observed, there are many independant resources. But my point 
> is that it isn't going away while apps still use it, so my 
> point is that this might be an easy way to improve it.

It's not just those MTA's using it. Worse, many watchdog implementations use it too, and they will reload the box if the load is too
high.

So we do need some ways to make the loadavg more meaningful or at least more predictable.

Hua

