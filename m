Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTKXDoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 22:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTKXDoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 22:44:20 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:64396 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261898AbTKXDoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 22:44:20 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "John Smith" <penguin2047@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: calling do_page_fault() 
In-reply-to: Your message of "Sun, 23 Nov 2003 22:18:10 CDT."
             <BAY10-DAV40oIi7Zdg7000019e5@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Nov 2003 14:43:27 +1100
Message-ID: <4808.1069645407@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Nov 2003 22:18:10 -0500, 
"John Smith" <penguin2047@hotmail.com> wrote:
>In Linux kernel 2.4.20 i368 arch, how come there is no reference to the 
>function do_page_fault() ?

arch/i386/kernel/entry.S:       pushl $ SYMBOL_NAME(do_page_fault)

called from asm.

