Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTJVX5P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJVX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:57:15 -0400
Received: from main.gmane.org ([80.91.224.249]:6631 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261298AbTJVX5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:57:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [pm] fix time after suspend-to-*
Date: Thu, 23 Oct 2003 01:57:10 +0200
Message-ID: <yw1xr814q10p.fsf@kth.se>
References: <20031022233306.GA6461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:RUYeKdIo+K4gYSEtSiY4p7d8YhY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> @@ -271,16 +271,39 @@
>  	unsigned long retval;
>  
>  	spin_lock(&rtc_lock);
> -
>  	retval = mach_get_cmos_time();
> -
>  	spin_unlock(&rtc_lock);
>  
>  	return retval;

I just love these subtle little fixes.  They can really make a
difference.

-- 
Måns Rullgård
mru@kth.se

