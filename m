Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTJDQVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTJDQVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:21:46 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:61900 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S262456AbTJDQVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:21:45 -0400
To: linux-kernel@vger.kernel.org
Cc: Delian Krustev <krustev@krustev.net>
Subject: Re: permissions inside linux-2.6.0-test6.tar.bz2
In-Reply-To: <CJIC.4he.15@gated-at.bofh.it>
References: <CJIC.4he.15@gated-at.bofh.it>
Date: Sat, 4 Oct 2003 18:21:38 +0200
Message-Id: <E1A5pA2-0008ES-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, these files are not world readable as they should be.
> I bumped into this while trying to compile the kernel from user.
> Anyone trying to do so and trying to use one of these files is
> affected.
[...]
> One more thing I want to recommend. Please use the tar options
> --owner 0 --group 0 when creating the archive. The uid/gid 1046
> combination might already be present on the system(or appear in
> the future) and might bring security risks for the unwary.

Just don't unpack the sources as the user wanting to do the
compile, then tar can't set file ownership and the permissions are
okay for compiling.

-- 
Ciao,
Pascal
