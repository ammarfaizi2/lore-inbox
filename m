Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSLIDkB>; Sun, 8 Dec 2002 22:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSLIDkB>; Sun, 8 Dec 2002 22:40:01 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44559
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262387AbSLIDkA>; Sun, 8 Dec 2002 22:40:00 -0500
Subject: Re: Detecting threads vs processes with ps or /proc
From: Robert Love <rml@tech9.net>
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212090319.gB93J7p20606@schroeder.cs.wisc.edu>
References: <200212090024.gB90OTN25818@saturn.cs.uml.edu>
	 <200212090319.gB93J7p20606@schroeder.cs.wisc.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039405679.14167.19.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 08 Dec 2002 22:47:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 22:18, Nick LeRoy wrote:

> Yeah, I thought of that, too.  Probably not too likely, of course, but it 
> still there.  Murphy rules.
> 
> Robert:  Any thoughts on this?

Sure, it can happen.  The original poster asked me this in private the
other day.  The race is pretty improbable but it certainly can happen. 
The heuristic is imperfect.  Then again, this same sort of thing can
occur in other places too since all the reads in /proc are non-atomic
wrt each other.

	Robert Love


