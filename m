Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUFNHZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUFNHZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 03:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUFNHZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 03:25:19 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15366 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261988AbUFNHZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 03:25:15 -0400
Message-ID: <40CD5384.1050809@aitel.hist.no>
Date: Mon, 14 Jun 2004 09:28:04 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ndiamond@despammed.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling
References: <200406140223.i5E2N1k18221@mailout.despammed.com>
In-Reply-To: <200406140223.i5E2N1k18221@mailout.despammed.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiamond@despammed.com wrote:

> I am not asking for
>help in solving this particular panic,
>I am asking for help in general, in
>getting information displayed when it
>needs to be displayed.
>  
>
I have struggled with this from time to time.  Wanting to
report a trace, but it is too long for the screen. 

Using a framebuffer console helps a lot.  I use 1280x1024 resolution,
and 8x8 characters.  The resulting 160x128 console isn't
that fun to _work_ with, but most panics/oopses fit.  I rarely
work at the console anyway.  If you do, consider making two almost
identical kernels where console font size is the only difference.  (The
extra compile takes very little time.)  Then use the small-font kernel
when debugging.

Helge Hafting

