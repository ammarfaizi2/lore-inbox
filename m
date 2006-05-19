Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWESTqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWESTqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWESTqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:46:54 -0400
Received: from jacks.isp2dial.com ([64.142.120.55]:11268 "EHLO
	jacks.isp2dial.com") by vger.kernel.org with ESMTP id S932168AbWESTqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:46:53 -0400
From: John Kelly <jak@isp2dial.com>
To: "Hua Zhong" <hzhong@gmail.com>
Cc: "'Eric W. Biederman'" <ebiederm@xmission.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'Herbert Poetzl'" <herbert@13thfloor.at>, <serue@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <dev@sw.ru>, <devel@openvz.org>,
       <sam@vilain.net>, <xemul@sw.ru>, <haveblue@us.ibm.com>,
       <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Date: Fri, 19 May 2006 15:45:43 -0400
Message-ID: <200605191945.k4JJjguK012606@isp2dial.com>
References: <m1iro2yo7f.fsf@ebiederm.dsl.xmission.com> <008201c67b71$fb938db0$493d010a@nuitysystems.com>
In-Reply-To: <008201c67b71$fb938db0$493d010a@nuitysystems.com>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Hard2Crack: 0.001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 11:28:08 -0700, "Hua Zhong" <hzhong@gmail.com>
wrote:

> how many virtualization technologies Linux should support?

> Particularly, does it need to support both OS-level virtualization

If users want it.  I do.


> It seems at least the VM approach is much less risky. It might be helpful
> if someone could explain why we need both.

A better question is, why can't we have both?

I don't have unlimited memory and disk.  I need to conserve my
resources as much as possible.

The one-kernel approach saves memory, leaving more for applications.
That's important to me.  I don't need to run multiple kernels, and I
don't want to.  I only want multiple secure operating environments.

The one-kernel approach also makes it easy to have all VPS in one disk
partition, without the performance penalty of file backed I/O.

If the VM approach is truly less risky, seems to me the Xen/VMware
developers should be able to succeed independently, despite changes
made for in-kernel virtualization.

I'm glad someone asked a question I could answer.  :-)


