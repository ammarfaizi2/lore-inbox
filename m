Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSAVK0R>; Tue, 22 Jan 2002 05:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289238AbSAVK0I>; Tue, 22 Jan 2002 05:26:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:23310 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289236AbSAVK0A>;
	Tue, 22 Jan 2002 05:26:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Giacomo Catenazzi <cate@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2-2.1.3 is available 
In-Reply-To: Your message of "Tue, 22 Jan 2002 11:09:14 BST."
             <3C4D3A4A.6020603@debian.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 21:25:48 +1100
Message-ID: <15312.1011695148@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002 11:09:14 +0100, 
Giacomo Catenazzi <cate@debian.org> wrote:
>Keith Owens wrote:
>> Watch out for the generated autoconf.h file, it might confuse some
>> people.
>
>Where?
>
>I don't find it in:
>http://lxr.linux.no/search?v=2.4.17&string=autoconfigure

All the make *config entries generate include/linux/autoconf.h, it is
the C representation of .config.  Some people may think that autoconf.h
is created by make autoconfig when it is really created by all *config
steps.

