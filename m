Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVHBS6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVHBS6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVHBS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:58:22 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:29127 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261684AbVHBS6U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:58:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=llSviQ8YuAPtAYAjguCYYi/fzXSB+SjDD7IRS67gkpNKgC9Gb6eriQ6g1Qs2z0b6de9WrpAcUvcP7uQgUeX60JiM9ffUHfI7Sv8PmyqknP4GNMRAdPtoYpRdLiswRoU923YJ3FBvOhWwkGlme38sXNePMqW9UMUGqfNcLdopzHE=
Message-ID: <9a8748490508021158147bd293@mail.gmail.com>
Date: Tue, 2 Aug 2005 20:58:19 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Michael D. Setzer II" <mikes@kuentos.guam.net>
Subject: Re: kernel options for cd project with processor family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EFDC63.31465.58ED66@mikes.kuentos.guam.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Michael D. Setzer II <mikes@kuentos.guam.net> wrote:
> I'm working on the ghost for linux project, which uses various
> kernels. The older version 0.14 version had two kernels that support
> some configurations. I've added a number of additional builds
> adding extra features, but left earlier version in case the later
> additions didn't work with hardware. The bzImage6 is the latest and
> it works with most hardware, but I found it didn't work on a K6, since
> it was build with the Pentium Pro Family. I was able to build one with
> the K6 family, and it worked. I had used one of the original kernels
> with a K6 before, but this one had a network card that wasn't
> supported by it.
> 
> I've built a test set of kernels with the same configuration as the
> bzImage6, but changed the Processor family. Below is a list of the
> build. I'm interested in which ones would make a difference. I would
> think that the 386 version would probable work on all hardware, but
> at what cost in performance for creating and restoring the disk
> images. G4L uses basically dd, gzip, lzop, bzop, ncftpget, and
> ncftpput. With all these images, the g4l iso image is 50MB.
> 
I'm a Slackware Linux user, and for ages Slackware kernels were build
for i386, releatively recently that was changed to i486 - my point
with this is that while my own custom kernels are slightly faster when
build for my K7, they are not significantly faster than the stock
distro kernels - I mean, I can mesure a difference with benchmarks,
but I don't actually feel/notice the difference.  So, for something
like your project I'd say build the kernel for i386 or i486 and have
it run on as many boxes as possible and don't loose sleep over loosing
performance from that.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
