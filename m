Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFAFnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 01:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTFAFnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 01:43:05 -0400
Received: from miranda.zianet.com ([216.234.192.169]:44041 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S261280AbTFAFnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 01:43:04 -0400
Subject: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054446976.19557.23.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 31 May 2003 23:56:16 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I've been converting the few files with old-style function prototypes to
ANSI C, and I would like to make sure the following is acceptable. 

Original form:

int
foo()
{
   	/* body here */
}	

Proposed conversion:

int foo(void)
{
   	/* body here */
}	

The above should be straightforward, but if there are any problems with
that, please holler.  I'll be sending patches through the maintainers
soon.

Steven

