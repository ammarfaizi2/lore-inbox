Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTEFTI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264035AbTEFTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:08:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48965 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S264034AbTEFTI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:08:26 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
References: <20030506164252.GA5125@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 13:17:48 -0600
In-Reply-To: <20030506164252.GA5125@mail.jlokier.co.uk>
Message-ID: <m13cjranqb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> So, as dynamic loading is ok between parts of Linux and binary-only
> code, that seems to imply we could build a totally different kind of
> binary-only kernel which was able to make use of all the Linux kernel
> modules.

If you build a kernel to run Linux drivers that seems to scream
derivative work to me.

>  We could even modularise parts of the kernel which aren't
> modular now, so that we could take advantage of even more parts of Linux.
> 
> What do you think?

At the very best support wise you would fall under the same category
as if you loaded a binary only driver.

On a very practical side you would suffer severe bitrot.  As I have
seen no project that has attempted this being able to keep up with 
the kernel API.  Netkit, Mach and MILO are good examples of why not to
do this.

Eric
