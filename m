Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSAGIuX>; Mon, 7 Jan 2002 03:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289144AbSAGIuM>; Mon, 7 Jan 2002 03:50:12 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3834 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289140AbSAGIuC>; Mon, 7 Jan 2002 03:50:02 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020105050412.A25073@baldur.yggdrasil.com> 
In-Reply-To: <20020105050412.A25073@baldur.yggdrasil.com> 
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
Subject: Re: Patch: linux-2.5.2-pre8/fs/jffs2 compilation fixes 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Jan 2002 08:49:57 +0000
Message-ID: <1033.1010393397@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


adam@yggdrasil.com said:
> dir.c needed to include <linux/sched.h> for CURRENT_TIME, and there
> were a couple of kdev-related changes. Here is the patch.

Thanks. This, and the JFFS changes, look OK. I've merged the sched.h 
inclusion into CVS, albeit without the comment - the Linux include files 
are screwed up enough that it's best not to pretend there's any logic 
behind what you have to include :)

I'm not merging the s/MAJOR/major/ changes into my tree just yet - I'm still
vaguely hoping the new macro will change name before 2.5.2 proper.

--
dwmw2


