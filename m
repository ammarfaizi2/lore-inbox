Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263146AbVGOCIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbVGOCIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbVGOCIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:08:32 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:34711 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263146AbVGOCG2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:06:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZMfxqt2kDmsiPyzND1WEtrn9r6PseyWN3yvnRwhGZgFdgLKhiMmsTFp3B44wSYdlxqtH9nNQQZG2zGLKzI2vtFAwFvYbR5ujN967O+dcMyYBNHO8lVD5gOK1iFik5sB08keZpTZfCmvwZI1kEHan1hEBpUAoR67qMipkfibpZRY=
Message-ID: <9a8748490507141906fb7e5b@mail.gmail.com>
Date: Fri, 15 Jul 2005 04:06:28 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Cc: Andi Kleen <ak@suse.de>, Mark Gross <mgross@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42D71950.20303@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
	 <p73wtnsx5r1.fsf@bragg.suse.de>
	 <9a8748490507141845162c0f19@mail.gmail.com>
	 <42D71950.20303@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/05, Chris Friesen <cfriesen@nortel.com> wrote:
> Jesper Juhl wrote:
> 
> > In my oppinion it would be nice if Linus/Andrew had some basic
> > regression tests they could run on kernels before releasing them.
> 
> How do you regression test behaviour on broken hardware (and BIOSes)
> that you don't have?
> 
That, of course, you cannot do. But, you can regression test a lot of
other things, and having a default test suite that is constantly being
added to and always being run before releases (that test hardware
agnostic stuff) could help cut down on the number of regressions in
new releases.
You can't test everything this way, nor should you, but you can test
many things, and adding a bit of formal testing to the release
procedure wouldn't be a bad thing IMO.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
