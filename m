Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTEFTdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbTEFTdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:33:13 -0400
Received: from mail.webmaster.com ([216.152.64.131]:64910 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261161AbTEFTdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:33:12 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "David S. Miller" <davem@redhat.com>, "Yoav Weiss" <ml-lkml@unpatched.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: The disappearing sys_call_table export.
Date: Tue, 6 May 2003 12:45:40 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEGACMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <1052212504.983.16.camel@rth.ninka.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 2003-05-06 at 01:45, Yoav Weiss wrote:
> > In fact, in linux which is opensource, you can probably write a script
> > that extracts any unexported symbol from the source code, find a path to
> > it from some exported symbol, and automagically create a module that
> > re-exports this symbol for your legacy driver to use.

> You might have a derivative work after obtaining access to a
> non-exported interface.  If this is correct, binary-only modules
> can't do this and therefore they must stick to exported interfaces.

	Obviously you don't have much experience getting around licenses. ;)

	You GPL the part that does the dirty work. Then your closed-source module
only uses exported interfaces and the boundary between GPL and closed-source
code is a clear license boundary.

	DS


