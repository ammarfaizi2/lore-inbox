Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbTLEU0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTLEU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:26:47 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:42835 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S264362AbTLEU0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:26:44 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Filip Van Raemdonck'" <filipvr@xs4all.be>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 12:26:39 -0800
Organization: Cisco Systems
Message-ID: <000301c3bb6e$16cf8000$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <20031205195609.GA30309@debian>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll rephrase what I wrote and what people have been saying 
> all the time:
> 
> "Once you build a binary module, it contains our (inlined) 
> code and thus the binary module is a derived work."

Understood and that's what we disagree.

By the way, what's so different between code and data, anyway?

Are inline functions more important than macros and defs?

> > Otherwise, since SCO found a few lines of code copied from 
> Unix in Linux
> > source, are we saying the whole million lines of code is 
> derived from
> > Unix?
> 
> We have yet to see if they actually found code.

We have. Some malloc function as I remember, and has been removed from
current Linux sources.

> And no; we're not saying all code is a derived work. We're 
> saying that if there is a few lines of copied code, then the 
> compiled kernel which contains object code coming from 
> these lines is a derived work. If. 

You are trying to hide the fact that the kernel "sources" actually
contained copyrighted code.

Binary modules do not _contain_ copyrighted (GPL'ed) code, they merely
_include_ it (by #inlucde), but the _compiled_ binary modules contain
compiled copyrighted (GPL'ed) code.

So you are saying, binary modules contain compiled GPL'ed code, so it's
derived work of GPL'ed code. But kernel sources contained copyrighted
(non-GPL'ed) code, but the sources were not derived work of that code,
only the compiled form was?

> Regards,
> 
> Filip

