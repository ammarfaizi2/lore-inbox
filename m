Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261909AbREPTxj>; Wed, 16 May 2001 15:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbREPTx3>; Wed, 16 May 2001 15:53:29 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:39559 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261909AbREPTxU>; Wed, 16 May 2001 15:53:20 -0400
From: Christoph Rohland <cr@sap.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.GSO.4.21.0105161416120.26191-100000@weyl.math.psu.edu>
Organisation: SAP LinuxLab
Date: 16 May 2001 21:47:16 +0200
In-Reply-To: <Pine.GSO.4.21.0105161416120.26191-100000@weyl.math.psu.edu>
Message-ID: <m3d7995b5n.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Wed, 16 May 2001, Alexander Viro wrote:
> Because what I need is an absolute minimum. Heck, I don't even use
> regular files (in the full variant of patch, that is). They might
> become useful, but I can live with mkdir() and mknod().

So what about adding shmem_mknod and shmem_mkdir to the core shmem.c
part? They are now under CONFIG_TMPFS but are only ~20 lines of code.

Greetings
		Christoph


