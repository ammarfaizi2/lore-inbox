Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293218AbSCWPSk>; Sat, 23 Mar 2002 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293245AbSCWPSa>; Sat, 23 Mar 2002 10:18:30 -0500
Received: from www.wen-online.de ([212.223.88.39]:56588 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S293218AbSCWPSW>;
	Sat, 23 Mar 2002 10:18:22 -0500
Date: Sat, 23 Mar 2002 16:36:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>
Subject: [datapoint] Re: 2.5.7 rm -r in tmpfs problem
In-Reply-To: <Pine.LNX.4.10.10203221241460.12354-100000@mikeg.wen-online.de>
Message-ID: <Pine.LNX.4.10.10203231619490.292-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Mike Galbraith wrote:

> Greetings,
> 
> While doing some testing, I ran into a problem where rm -r doesn't
> remove all files in a tmpfs directory is there are lots of files
> in that directory.  (rm -rf linux is failing)

I traced this back to the locking changes introduced in 2.5.5-pre1,
and verified it by moving the changes for the filesystems I use into
an otherwise pristine 2.4.4.

(experience says giving up would probably be wise at this point:)

	-Mike

