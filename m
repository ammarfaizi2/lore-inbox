Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269386AbUJSIUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269386AbUJSIUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJSIUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:20:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12009 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269190AbUJSITW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:19:22 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH to fix depmod failure for modules-install of a cross compiled kernel. (fwd) 
In-reply-to: Your message of "Mon, 18 Oct 2004 19:07:07 +0100."
             <Pine.LNX.4.10.10410181905110.29938-100000@mtfhpc.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Oct 2004 18:11:42 +1000
Message-ID: <9661.1098173502@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 19:07:07 +0100 (BST), 
Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:
># 'depmod' (module-init-tools-3.0) core dumped. The tempory
># solution is to disable 'depmod' when cross compiling.

When cross compiling, specify 'DEPMOD=/bin/true' on the command line to
turn it into a no-op.

