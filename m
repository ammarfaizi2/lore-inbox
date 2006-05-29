Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWE2FRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWE2FRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 01:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWE2FRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 01:17:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46755 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751186AbWE2FRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 01:17:40 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: yh@bizmail.com.au
cc: linux-kernel@vger.kernel.org
Subject: Re: Error of building modutils-2.4.27 
In-reply-to: Your message of "Mon, 29 May 2006 15:23:27 +1000."
             <3140.58.105.227.226.1148880207.squirrel@58.105.227.226> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 May 2006 15:17:09 +1000
Message-ID: <6627.1148879829@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yh@bizmail.com.au (on Mon, 29 May 2006 15:23:27 +1000 (EST)) wrote:
>Hello,
>
>If the subject is not appropriate to this list, please point me a proper
>mailing list.
>
>While I am building modutils-2.4.27 by FC5, I've got following errors:
>
>../../obj/obj_kallsyms.c:204: error: invalid lvalue in assignment
>../../obj/obj_kallsyms.c:279: error: invalid lvalue in assignment

Why are you building modutils 2.4?  FC3 and later Fedora distributions
use the newer module-init package which is required for 2.6 kernels.
modutils is only for 2.4 and earlier kernels, which are quite difficult
to run on FC5.

