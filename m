Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUHOScq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUHOScq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 14:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUHOScp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 14:32:45 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39282 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266839AbUHOSco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 14:32:44 -0400
Date: Sun, 15 Aug 2004 20:35:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Aloni <da-x@colinux.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [#3 1/2] Generate vmlinux.lds instead of vmlinux.lds.s
Message-ID: <20040815183516.GA7682@mars.ravnborg.org>
Mail-Followup-To: Dan Aloni <da-x@colinux.org>,
	Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org> <20040813080941.GA7639@callisto.yi.org> <20040813092426.GA27895@callisto.yi.org> <20040813183347.GA9098@mars.ravnborg.org> <20040814194625.GA20753@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814194625.GA20753@callisto.yi.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 10:46:25PM +0300, Dan Aloni wrote:
> Hello Sam,
> 
> Here's the first patch. Note that I had to choose PPFLAGS instead 
> of CPPFLAGS because otherwise it would have collided with the other
> uses of CPPFLAGS.
That collision was intentional.
I have changed that to cppflags and added both your patches to my tree.
The 2/2 missed a few *lds files which added also.
Thanks for your effort!


	Sam
