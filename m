Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130977AbRCFPvA>; Tue, 6 Mar 2001 10:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130981AbRCFPuu>; Tue, 6 Mar 2001 10:50:50 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:3969 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130977AbRCFPug>; Tue, 6 Mar 2001 10:50:36 -0500
Date: Tue, 6 Mar 2001 15:53:43 +0000 (GMT)
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Laramie Leavitt <laramie.leavitt@btinternet.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010306151242.D31649@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.30.0103061549480.8457-100000@dax.joh.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Sean Hunter wrote:

>
> I propose
> /proc/sys/kernel/im_too_lame_to_learn_how_to_use_the_most_basic_of_unix_tools_so_i_want_the_kernel_to_be_filled_with_crap_to_disguise_my_ineptitude
>
> Any support?

Hrm - make it part of the "fscking_moron" subsystem.

/proc/sys/kernel/fscking_moron/stupidity_workarounds/cant_handle_ascii/broken_shellscript_hack

It would be nice if the shell's error message gave a bit more information
on the problem, but that's a userspace issue IMHO: make *sh check for this
kind of mistake and say "interpreter for shell script not found",
something like that. Whatever, it's NOT a kernel issue.

Maybe the kernel could return a different error value, though - just
saying "file not found" isn't very helpful...


James.

