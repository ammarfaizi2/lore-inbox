Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUJPWBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUJPWBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUJPWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 18:01:35 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:12438 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268920AbUJPWBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 18:01:24 -0400
Date: Sun, 17 Oct 2004 02:01:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name
Subject: Re: [PATCH] patsubstfor LOCALVERSION and -fno-omit-frame-pointer
Message-ID: <20041017000126.GD15006@mars.ravnborg.org>
Mail-Followup-To: Tejun Heo <tj@home-tj.org>,
	linux-kernel@vger.kernel.org, kai@germaschewski.name
References: <20040912093635.GD13359@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912093635.GD13359@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 06:36:35PM +0900, Tejun Heo wrote:
>  (** Sorry, I'm resending this mail.  I had written the subject in the
> Reply-To field. **)
> 
>  Hello, I'm attaching two patches for the top Makefile.
> 
>  The first patch modifies LOCALVERSION definition such taht it uses
> patsubst instead of subst to remove surrounding double quotes from
> CONFIG_LOCALVERSION.  This helps syntax-highlighting editors.
> 
>  The second patch addes -fno-omit-frame-pointer to CFLAGS when
> CONFIG_FRAME_POINTER is set.  My gcc (gcc-3.3.4 Debian 1:3.3.4-11)
> automatically turns on -fomit-frame-pointer when -O2 is specified and
> thus breaks CONFIG_FRAME_POINTER option.  I'm not sure if other
> versions of gcc wouldn't choke with -fno-omit-frame-pointer.  My 2.95
> (2.95.4) seems to be OK though.

Applied both.
Next time please send a single patch/mail.

	Sam
