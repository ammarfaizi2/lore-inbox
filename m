Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWJFOeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWJFOeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWJFOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:34:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422692AbWJFOeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:34:08 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061006141704.GH2563@parisc-linux.org> 
References: <20061006141704.GH2563@parisc-linux.org>  <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 06 Oct 2006 15:33:44 +0100
Message-ID: <10081.1160145224@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:

> Why not "def_bool n"?

def_bool?  What's that?  default + bool?  I don't remember seeing any of those
in any of the files I looked in.

> Or indeed, since the default is n, why not just "bool"?

*shrug*

I'd prefer to default all of these in a common place rather than having to
relentlessly duplicate them over all archs.  Is that possible?

David
