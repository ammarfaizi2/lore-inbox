Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSCSKqL>; Tue, 19 Mar 2002 05:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCSKqA>; Tue, 19 Mar 2002 05:46:00 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:40943 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310619AbSCSKpy>; Tue, 19 Mar 2002 05:45:54 -0500
Date: Tue, 19 Mar 2002 10:45:48 +0000 (GMT)
From: David Woodhouse <dwmw2@redhat.com>
X-X-Sender: dwmw2@passion.cambridge.redhat.com
To: Paul Mackerras <paulus@samba.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zlib double-free bug 
In-Reply-To: <15510.25987.233438.112897@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0203191044150.26226-100000@passion.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Paul Mackerras wrote:

> David Woodhouse writes:
> 
> > After it's been in -ac for a while without mishap I'll ask Marcelo to
> > consider it - possibly for 2.4.20-pre1.
> 
> Yep, that sounds good to me.  For now, I think my patch should go in
> for 2.4.19.

Absolutely - sorry, I didn't mean to imply otherwise.

For the record - it's not worth bothering with fs/jffs2/zlib.c; if they 
can corrupt your file system on the medium, why bother with cracking zlib? 
:)

-- 
dwmw2

