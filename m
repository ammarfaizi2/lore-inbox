Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSCVHaK>; Fri, 22 Mar 2002 02:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292482AbSCVHaA>; Fri, 22 Mar 2002 02:30:00 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:10745 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S291766AbSCVH3p>; Fri, 22 Mar 2002 02:29:45 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C9A758D.103@acm.org> 
To: Corey Minyard <minyard@acm.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Rini <trini@kernel.crashing.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zlib double-free bug 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Mar 2002 07:26:20 +0000
Message-ID: <8274.1016781980@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


minyard@acm.org said:
> > 2.4.19ac has the shared zlib already. The zlib sharing stuff wasnt a
> > 2.5 patch backported - its a 2.4 fix that went forward

> Since I did the original shared zlib patch and I did it to 2.5, either
> we have two patches floating around or you are incorrect.  If we have 
> two patches, we need to resolve the situation. 

The patch that's now in the -ac tree is a backport of the 2.5 code, after we
actually made the 2.5 code _work_, that is.

Alan's right that there was at least _some_ work on a shared zlib in 2.4, 
though.


--
dwmw2


