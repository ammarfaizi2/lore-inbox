Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbTCKR4I>; Tue, 11 Mar 2003 12:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbTCKR4I>; Tue, 11 Mar 2003 12:56:08 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:47585 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S261601AbTCKR4G> convert rfc822-to-8bit; Tue, 11 Mar 2003 12:56:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Prasad <prasad_s@students.iiit.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Resending] User Process and a Kernel Thread
Date: Tue, 11 Mar 2003 12:04:48 -0600
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0303112306530.26279-100000@students.iiit.net>
In-Reply-To: <Pine.LNX.4.44.0303112306530.26279-100000@students.iiit.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303111204.48708.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 March 2003 11:37 am, Prasad wrote:
> Resending the mail...
>
> Hi all,
> 	Whats the difference between the user process and a kernel thread?

Kernel process/thread has access to all hardware capability. No security can 
be envorced.

User process is limited to the memory the kernel allocates to the process. No
direct device access, no access to all system resources. All hardware access
is mediated by the kernel. Some privileged operations can be delegated to a
user process (see X server running without frame buffer support).

> IS it possible to make the kernel thread a user process?

No

>if yes, how do we
> do that?
>
> Prasad.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
