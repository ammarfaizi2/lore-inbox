Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbTJaADc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJaADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:03:32 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56082
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262928AbTJaADb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:03:31 -0500
Subject: Re: uptime reset after about 45 days
From: Robert Love <rml@tech9.net>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bns75b$ssn$1@news.cistron.nl>
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
	 <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
	 <bns75b$ssn$1@news.cistron.nl>
Content-Type: text/plain
Message-Id: <1067558584.1183.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Oct 2003 19:03:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-30 at 18:34, Miquel van Smoorenburg wrote:

> No, that's only on 2.6, and it has been fixed in 2.6 too.
> The 2.4 32 bits kernels run with HZ=100.
> 
> Sounds like the gentoo-kernel has just upped HZ to 1000 without
> fixing these problems properly. That's .. disappointing.

Yup.  Last I heard, they merged the variable-HZ patch, set HZ to 1000,
but did but merge Tim's 64-bit jiffies patch.

So they roll over in 49 days.

	Robert Love


