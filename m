Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTJAKUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTJAKUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:20:19 -0400
Received: from [212.97.163.22] ([212.97.163.22]:54148 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261842AbTJAKUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:20:13 -0400
Date: Wed, 1 Oct 2003 12:20:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031001102001.GA3495@werewolf.able.es>
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> (from Andries.Brouwer@cwi.nl on Wed, Oct 01, 2003 at 02:01:23 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.01, Andries.Brouwer@cwi.nl wrote:
> Hi Linus,
> 
> Something we have talked about for a long time is
> separating out from the kernel headers the parts
> fit for inclusion in user space.
> 
> This is a very large project, and it will take a long
> time, especially if we want the user space headers to
> be a pleasure to look at, instead of just a cut-n-paste
> copy of whatever we find in the current headers.
> 
> Some start is required, and the very first step is
> making sure that you agree with the project.
> Immediately following is the choice of directory names.
> 
> Below
>   (i) a small textfile "linuxabi" describing the naming
> (subdirectories linuxabi and linuxabi-alpha etc of include),

Why not just 'abi' ? Simpler, and allows glibc to include
just 'abi/xxxx' in other systems if they follow the same convention (BSD?) ?

Where would this live in userspace, /usr/include/abi or /usr/include/linux/abi ?
How would this relate to current /usr/include/linux 
(symlink /usr/include/linux to /usr/include/abi) ?

Just curious.

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
