Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbSKOXxs>; Fri, 15 Nov 2002 18:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbSKOXxs>; Fri, 15 Nov 2002 18:53:48 -0500
Received: from fmr04.intel.com ([143.183.121.6]:35301 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S266940AbSKOXxq>; Fri, 15 Nov 2002 18:53:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Reserving "special" port numbers in the kernel ?
From: Arun Sharma <arun.sharma@intel.com>
Date: 15 Nov 2002 16:00:37 -0800
Message-ID: <uel9mbcyi.fsf@unix-os.sc.intel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One of the Intel server platforms has a magic port number (623) that
it uses for remote server management. However, neither the kernel nor
glibc are aware of this special port.

As a result, when someone requests a privileged port using
bindresvport(3), they may get this port back and bad things happen.

Has anyone run into this or similar problems before ? Thoughts on
what's the right place to handle this issue ?

        -Arun

