Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVAOBRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVAOBRD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVAOBMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:12:45 -0500
Received: from gw.goop.org ([64.81.55.164]:24215 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262089AbVAOBJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:09:09 -0500
Subject: Re: 2.6.10-mm3: lseek broken on /proc/self/maps
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Prasanna Meda <pmeda@akamai.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41E867DE.11F4016A@akamai.com>
References: <1105737819.11209.9.camel@localhost>
	 <41E867DE.11F4016A@akamai.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 17:05:48 -0800
Message-Id: <1105751148.4150.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 16:46 -0800, Prasanna Meda wrote:
> Thanks a lot  for testing all the corner cases.

I'm actually trying to find bugs in Valgrind's memory map tracking code,
but so far all the problems have been in /proc/self/maps (which I had
been treating as a golden reference...).

I'll give this a go shortly.  

BTW, your last patch fixed the >4k read problem, so I'm hoping this will
be the last one.

	J

