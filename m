Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUHWPeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUHWPeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUHWPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:31:10 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:11527 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265053AbUHWPZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:25:22 -0400
Date: Mon, 23 Aug 2004 17:25:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Lei Yang <leiyang@nec-labs.com>
Cc: root@chaos.analogic.com, Lee Revell <rlrevell@joe-job.com>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
Message-ID: <20040823152540.GA8791@mars.ravnborg.org>
Mail-Followup-To: Lei Yang <leiyang@nec-labs.com>,
	root@chaos.analogic.com, Lee Revell <rlrevell@joe-job.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040821214402.GA7266@mars.ravnborg.org> <4127A662.2090708@nec-labs.com> <20040821215055.GB7266@mars.ravnborg.org> <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net> <4129FAC8.3040502@nec-labs.com> <Pine.LNX.4.53.0408231018001.7732@chaos> <412A01AC.5020108@nec-labs.com> <Pine.LNX.4.53.0408231046190.7816@chaos> <412A077C.1080501@nec-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412A077C.1080501@nec-labs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 11:04:28AM -0400, Lei Yang wrote:
> 
> Sort of, I am trying to make a usr mode library work with kernel. 
> However, floating point operation is necessary in the algorithm. You 
> mean that this can never be done? Is changing floating-point the only 
> thing I can do now?

Before helping out more with your compile issue please explain in propser
detail what you try to achive.
Reading the above I get the impression you thing a library will run
faster when running in kernel context - and thats what you try to do.

If this is your plan then the answer is: Drop it.

	Sam
