Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUKBJI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUKBJI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 04:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUKBJI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 04:08:56 -0500
Received: from gate.firmix.at ([80.109.18.208]:54952 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S268499AbUKBJIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 04:08:35 -0500
Subject: Re: [oops] lib/vsprintf.c
From: Bernd Petrovitsch <bernd@firmix.at>
To: Pawel Sikora <pluto@pld-linux.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0411020826520.12803@plus.ds14.agh.edu.pl>
References: <200411020719.55570.pluto@pld-linux.org>
	 <418728CA.1090707@yahoo.com.au>
	 <Pine.LNX.4.60.0411020826520.12803@plus.ds14.agh.edu.pl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1099386510.19137.7.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 02 Nov 2004 10:08:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 08:35 +0100, Pawel Sikora wrote:
> On Tue, 2 Nov 2004, Nick Piggin wrote:
> > Pawe Sikora wrote:
> >> vsprintf.c-      case 's':
> >> vsprintf.c-                    s = va_arg(args, char *);
> >> vsprintf.c-                    if ((unsigned long)s < PAGE_SIZE)
> >> vsprintf.c-                           s = "<NULL>";
> >> vsprintf.c-
> >> vsprintf.c:      OOPS!  =>     len = strnlen(s, precision);
> >
> > But it is the kernel module that's buggy. What's the problem?
> 
> I think that block similar to setjmp/longjmp should be placed
> around such dangerous places to refues future oops.

How do you want to find such bugs then?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

