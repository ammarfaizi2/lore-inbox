Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290318AbSAPA4j>; Tue, 15 Jan 2002 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAPAxp>; Tue, 15 Jan 2002 19:53:45 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:55829 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290310AbSAPAwF>; Tue, 15 Jan 2002 19:52:05 -0500
Date: Tue, 15 Jan 2002 19:52:04 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Weber <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020115195204.K17477@redhat.com>
In-Reply-To: <20020115194316.I17477@redhat.com> <Pine.LNX.4.33.0201151644180.1213-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201151644180.1213-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 15, 2002 at 04:44:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:44:54PM -0800, Linus Torvalds wrote:
> Numbers please.
> 
> I'd MUCH rather just clean up the include file hierarchy than have these
> kinds of non-local knowledge issues.

The last time I did it for fs.h et al (this meant pulling the fs.h and 
sched.h codependancy apart), it got 2.4 compiles back down to 2.2 compile 
times (3m -> 2m45s maybe 2m30s iirc) -- about a 10% drop in compile time.  
It's even more noticeable when you're doing a fully blown modular kernel 
build as distributions do.

		-ben
-- 
Fish.
