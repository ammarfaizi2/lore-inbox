Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261176AbRELEsW>; Sat, 12 May 2001 00:48:22 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261178AbRELEsM>; Sat, 12 May 2001 00:48:12 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:28166 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261176AbRELEsB>;
	Sat, 12 May 2001 00:48:01 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "crisper@optonline.net" <crisper@optonline.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.4-ac6, ksymoops output included 
In-Reply-To: Your message of "Fri, 11 May 2001 17:52:24 -0400."
             <0GD600C9PY3CHH@mta4.srv.hcvlny.cv.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 12 May 2001 14:47:55 +1000
Message-ID: <10760.989642875@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001 17:52:24 -0400 (EDT), 
"crisper@optonline.net" <crisper@optonline.net> wrote:
>ksymoops 2.4.1 on i686 2.4.4-ac6.  Options used
>Warning (read_object): no symbols in
>/lib/modules/2.4.4-ac6/build/drivers/pnp/pnp.o

ksymoops should not be reading objects from /build/.  It looks like you
are running an old modutils, you need at least modutils 2.4.2 for 2.4
kernels.

