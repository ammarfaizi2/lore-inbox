Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVDGSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVDGSHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDGSHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:07:01 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:2267 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262543AbVDGSGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:06:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gW5RYo47VSJgneMvUa+dqFjKSfYExaojDoRjyUZygWTGidTVj35Gk4E28AuaM+DAV9g5vH+5zdbsqBFefNkyzUcZHhsWXxCTPQlp+MfKnyvZ9zRMZWpvH+11AZha5l8s+ozC0WYr24rNAK8jQgR7tp5knZElVVZ+2c4PzO8Cco4=
Message-ID: <aec7e5c3050407110647927c1e@mail.gmail.com>
Date: Thu, 7 Apr 2005 20:06:46 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel SCM saga..
Cc: Daniel Phillips <phillips@istop.com>, Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
	 <200504071300.51907.phillips@istop.com>
	 <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 7:38 PM, Linus Torvalds <torvalds@osdl.org> wrote:
> So my prefernce is _overwhelmingly_ for the format that Andrew uses (which
> is partly explained by the fact that I am used to it, but also by the fact
> that I've asked for Andrew to make trivial changes to match my usage).
> 
> That canonical format is:
> 
>         Subject: [PATCH 001/123] [<area>:] <explanation>
> 
> together with the first line of the body being a
> 
>         From: Original Author <origa@email.com>
> 
> followed by an empty line and then the body of the explanation.
> 
> After the body of the explanation comes the "Signed-off-by:" lines, and
> then a simple "---" line, and below that comes the diffstat of the patch
> and then the patch itself.

While specifying things, wouldn't it be useful to have a line
containing tags that specifies if the patch contains new features, a
bug fix or a high-priority security fix? Then that information could
be used to find patches for the sucker-tree.

/ magnus
