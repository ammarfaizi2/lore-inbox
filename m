Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289661AbSA2Ojm>; Tue, 29 Jan 2002 09:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289564AbSA2Ojd>; Tue, 29 Jan 2002 09:39:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9988 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289645AbSA2OjS>; Tue, 29 Jan 2002 09:39:18 -0500
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
To: garzik@havoc.gtf.org (Jeff Garzik)
Date: Tue, 29 Jan 2002 14:51:43 +0000 (GMT)
Cc: raul@viadomus.com (DervishD), ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020129093024.E10404@havoc.gtf.org> from "Jeff Garzik" at Jan 29, 2002 09:30:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VZbr-00046x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your libc should provide a "sanitized" version of the kernel headers,
> which is completely separate from any kernel sources.
> 
> dietlibc does this...  it's completely independent of kernel header changes.
> 
> RedHat will be doing this with glibc in the future.

We already do. Red Hat shipped since about 7.0 has a seperate set of
kernel based headers that glibc uses for its own internal use, and the set
in the kernel sources.

Alan
