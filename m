Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTBBIlw>; Sun, 2 Feb 2003 03:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTBBIlw>; Sun, 2 Feb 2003 03:41:52 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:54172 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265169AbTBBIlv>; Sun, 2 Feb 2003 03:41:51 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Marinceu <elixxir@ucc.gu.uwa.edu.au>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.21.0302021616230.11976-100000@mussel>
References: <Pine.LNX.4.21.0302021616230.11976-100000@mussel>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Feb 2003 08:51:17 +0000
Message-Id: <1044175877.13350.5.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: [RFC][PATCH] new modversions implementation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-02 at 08:37, Paul Marinceu wrote:
> Also, whatever happened to modversions.h? A module I have refuses to
> compile without it. I'm not yet such a good hacker to figure out how your
> new modversions implementation works 8) 

Then that module was _always_ broken. The kernel build system always
included modversions.h for you iff you needed it. 

-- 
dwmw2

