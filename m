Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129983AbRAKOZZ>; Thu, 11 Jan 2001 09:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130706AbRAKOZQ>; Thu, 11 Jan 2001 09:25:16 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:19198 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129983AbRAKOZC>; Thu, 11 Jan 2001 09:25:02 -0500
Date: Thu, 11 Jan 2001 15:27:06 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bugreporting script - second try
In-Reply-To: <3A5DBFBC.88DFEBD7@neuronet.pitt.edu>
Message-ID: <Pine.LNX.4.30.0101111524190.21849-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Rafael E. Herrera wrote:

> I have a suggestion, there is a kernel patch to add a config.gz entry in
> the /proc fs. It reflects the configuration used in building the running
> kernel, which may differ from the one you have in /usr/src/linux. It's
> part of the suse distribution. The attached patch will use it, although
> you may want to add code to ask the user which one to use.

I have added your suggestion. If gzip and /proc/config.gz exist, the
latter is used.
I think /proc/config.gz is always the one. (There are many places where
the script assumes that you are running the kernel which caused the
problem.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
