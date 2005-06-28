Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVF1JIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVF1JIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVF1JIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:08:41 -0400
Received: from dial169-164.awalnet.net ([213.184.169.164]:30724 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S261745AbVF1JIj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:08:39 -0400
Message-Id: <200506280908.MAA13504@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Michal Schmidt'" <xschmi00@stud.feec.vutbr.cz>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 12:08:16 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <42C107CC.8070800@stud.feec.vutbr.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7uX3RjRSLIbRbRdK1n6LzKaCCkAABFv7g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> The kernel can always discard pages of executables and read-only mapped
files,
> because it can load them back if necessary.
> If you don't like this, call mlockall() in your program.

Thanks for the pointer, but what if I don't own the source.
Is there a way to tell kswapd to disable this feature?

