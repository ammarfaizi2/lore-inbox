Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVGLMkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVGLMkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVGLMig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:38:36 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:27313 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261402AbVGLMgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:36:15 -0400
Message-ID: <42D3B937.6030504@metaparadigm.com>
Date: Tue, 12 Jul 2005 20:36:07 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mariusz Gniazdowski <refuse@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I have centrino laptop with no freq/voltage tables in BIOS
References: <20050711141202.GA3735@mordor.lan>
In-Reply-To: <20050711141202.GA3735@mordor.lan>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Gniazdowski wrote:

>Hi.
>I have centrino laptop with no built-in frequency/voltage pairs in
>BIOS/ACPI. I have found this thread:
>
>http://lkml.org/lkml/2005/7/6/101
>
>  
>
If you read the thread more closely you'll become aware that the static
table approach is not really practicle. There is no way to find out at
runtime what voltage variant of Dothan chip your machine has
(VID#A,VID#B,VID# or VID#D). I became aware of that myself after
creating a static table patch (which I can send you offlist if you wish
although you risk running your chip at the wrong voltage unless you know
which variant of Dothan chip your manufacturer has used).

~mc
