Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTKQVSW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTKQVSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:18:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261660AbTKQVSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:18:20 -0500
Date: Mon, 17 Nov 2003 16:18:11 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: sds@epoch.ncsc.mil, <aviro@redhat.com>, <linux-kernel@vger.kernel.org>,
       <russell@coker.com.au>
Subject: Re: [PATCH][RFC] Remove CLONE_FILES from init kernel thread creation
In-Reply-To: <20031117124954.6fa4e366.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0311171616410.3201-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Andrew Morton wrote:

> No, I can't think of a reason why we'd need CLONE_FILES in there.  I'll
> toss it in and see what breaks.

Ok, also, for reference, Russell Coker discovered the issue and this fix
was suggested by Stephen Smalley.

> I wonder why call_usermodehelper() uses CLONE_FILES...

Because it's faster?


- James
-- 
James Morris
<jmorris@redhat.com>


