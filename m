Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263971AbTCUUOE>; Fri, 21 Mar 2003 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263980AbTCUUNC>; Fri, 21 Mar 2003 15:13:02 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:65028
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S263971AbTCUULe>; Fri, 21 Mar 2003 15:11:34 -0500
Subject: Re: [PATCH] to drivers/parport/ieee1284_ops.c to fix timing
	dependend
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Tim Josling <tej@melbpc.org.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Philip.Blundell@pobox.com
In-Reply-To: <3E782567.3020008@melbpc.org.au>
References: <3E782567.3020008@melbpc.org.au>
Content-Type: text/plain
Organization: 
Message-Id: <1048278154.6017.2.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 Mar 2003 12:22:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 00:08, Tim Josling wrote:
> I have an HP1100 printer and since I upgraded to a faster CPU the 
> printer has started hanging. The problem persisteed across 2.0 2.2 and 
> 2.4 kernel versions. I am running Red Hat Linux 8.0 on a Compaq Armada E500.
> 
> The problem occurs intermittently. The symptom is that the 'buffer 
> contains data' light stays on on the printer, but data transfer stops.

Ah, so that's why that happens.  I've been getting the same thing with
my LJ1100.

Is this just in polled mode?  Does using interrupts constitute a
work-around for the hang?

	J

