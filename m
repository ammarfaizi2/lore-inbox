Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTGGKNL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTGGKNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:13:11 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:28178 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262023AbTGGKNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:13:09 -0400
Date: Mon, 7 Jul 2003 20:27:15 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Christoph Hellwig <hch@infradead.org>
cc: Thomas Spatzier <TSPAT@de.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: crypto API and IBM z990 hardware support
In-Reply-To: <20030707081159.B1848@infradead.org>
Message-ID: <Mutt.LNX.4.44.0307072023590.3364-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Christoph Hellwig wrote:

> This sounds like the right way to do it.  The question is just whether we
> want to put that complicated policy into the kernel or into some userspace
> helper.

A userspace helper sounds interesting, as we also need a way to allow 
unprivileged users to invoke kernel crypto, which may require modules to 
be loaded.


- James
-- 
James Morris
<jmorris@intercode.com.au>

