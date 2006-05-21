Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWEUV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWEUV7l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEUV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:59:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:7664 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964944AbWEUV7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eJkNOXZLQE8hnmu7m09sfBuYb5UPu0sWJCNJBdq3KC9xnAedjzpzjfpnBzQDSBKkpKA1brx8+0Y7L7B48UZGoA/FhUzqvk+Gezl0dDSPXgTLSOV8OftL6X8pMRVA3U47S8BYS/XMWzFfMmGP/Cm/qrCvf0dVEf2XwWvGoDIrl1w=
Date: Sun, 21 May 2006 23:59:03 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Sam Vilain <sam@vilain.net>
Cc: cw@f00f.org, s0348365@sms.ed.ac.uk, jpiszcz@lucidpixels.com,
       linux-kernel@vger.kernel.org, apiszcz@lucidpixels.com
Subject: Re: Linux Kernel Source Compression
Message-Id: <20060521235903.1a058b23.diegocg@gmail.com>
In-Reply-To: <4470DEC4.6050308@vilain.net>
References: <Pine.LNX.4.64.0605211028100.4037@p34>
	<200605212003.32063.s0348365@sms.ed.ac.uk>
	<20060521210056.GA3500@taniwha.stupidest.org>
	<4470DEC4.6050308@vilain.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 22 May 2006 09:42:28 +1200,
Sam Vilain <sam@vilain.net> escribió:

> it's currently faster for me to download and unpack a .gz than to wait
> the extra time for bzip2 to decompress. I've always found it quicker


For kernel patches and kernel releases it sure doesn't have a lot of
sense to switch, you don't gain too much.

LZMA has its gains, though. It's probably a interesting choice
for packaging software: You may get some extra space in the CD thanks
to the extra compression, and the faster decompressing could make
installs a bit faster. While LZMA is slower as hell compressing in
the "best compression" mode, is faster than bzip2 when compressing and
decompressing at the same compression levels than bzip2 (according to
the previous web). That pretty much means it's just better.
