Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTLWEug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 23:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLWEug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 23:50:36 -0500
Received: from mail.webmaster.com ([216.152.64.131]:48369 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264940AbTLWEuf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 23:50:35 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Stan Bubrouski" <stan@ccs.neu.edu>, <linux-kernel@vger.kernel.org>
Subject: RE: SCO's infringing files list
Date: Mon, 22 Dec 2003 20:50:19 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIECDIPAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1072125736.1286.170.camel@duergar>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2055
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	These files seem to mostly include information from standards documents and
most likely contain insufficient original creative content to justify
copyright protection. The particular order in which one lists the defines or
the numbers one assigns to them don't seem to be protectable to me, there's
no expression in them.

	I had a similar issue in a code review. In this case, the relevant RFC
actually named the constants and gave their numerical values. The numerical
values are used in the protocol and it's logical for multiple independent
groups to both choose to use the same names used in the RFC. So our code had
one header file -- a list of '#define's with the same names and numbers as
someone else's code (and the same as the RFC, of course). And guess what, we
both put them in numerical order too!

	Not bothering to look at the RFC, the code reviewer concluded that the
identical symbol names must have meant one of us took code from the other.
Duh.

	DS


