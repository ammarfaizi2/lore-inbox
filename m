Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbULJC2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbULJC2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULJC2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:28:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49050 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261668AbULJC2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:28:32 -0500
Date: Thu, 9 Dec 2004 21:28:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Timothy Chavez <chavezt@gmail.com>
cc: linux-kernel@vger.kernel.org, <serue@us.ltcfwd.linux.ibm.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, <rml@novell.com>,
       <ttb@tentacle.dhs.org>, Peter Martuccelli <peterm@redhat.com>
Subject: Re: [audit] Upstream solution for auditing file system objects
In-Reply-To: <f2833c760412091602354b4c95@mail.gmail.com>
Message-ID: <Xine.LNX.4.44.0412092120330.13605-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Timothy Chavez wrote:

> Greetings, 
>  
> I'm writing this e-mail to facilitate some discussion on an audit
> feature for inclusion to the mainline kernel's audit subsysystem. 

Note, there is a mailing list intended for audit discussion at 
https://www.redhat.com/archives/linux-audit/

It's been a bit quiet, but it may be useful for detailed discussions.

> 2.  Linux Security Module.

As Chris said, LSM is not suitable for CAPP auditing.

> 3.  SELinux.

I don't think it's a good idea to tie everyone in to using SELinux.
Audit and SELinux do need to play well together though (and SELinux is 
already integrated with some of the existing audit subsystem).

> 4.  Audit subsystem.

IMHO we need a distinct Audit subsystem, perhaps even something which can 
accomodate different implementations.

> However, the most obvious gain here, is that the subsystem is
> centralized and its intentions are clearer.

Indeed.


- James
-- 
James Morris
<jmorris@redhat.com>


