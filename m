Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLWSoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTLWSoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:44:12 -0500
Received: from imo-d01.mx.aol.com ([205.188.157.33]:4859 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S262161AbTLWSoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:44:10 -0500
Message-ID: <3FE88CE8.1020109@netscape.net>
Date: Tue, 23 Dec 2003 14:43:52 -0400
From: John Gluck <jgluckca@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about setup.c 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 67.60.153.181
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been poking around the kernel startup code to try and understand 
the sequence of events. I came across something I don't understand and 
which might be redundant.

This is from the 2.6.0 kernel:

In arch/i386/kernel/setup.c the parse_cmdline_early() function, the 
argument "mem=XXX[kKmM]" is parsed.

In arch/sh/kernel/setup.c the parse_cmdline() function also parses 
"mem=XXX[kKmM]"

Could someone please explain this.

I am not subscribed to this list so a reply directly to me would be 
appreciated.

Thanks and a Merry Christmas to everyone

John

