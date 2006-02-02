Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWBBLoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWBBLoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWBBLoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:44:10 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:34401 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750905AbWBBLoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:44:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sBlRWJhpHN0nVxhf/jbAl6cI0k++XrnpIPhA+bl6+FYWI8WtFbOwo4ttDZg2GU3ucnsl2M5eWjZtLzTkG34htMRPyx0tX1xaNLuvNexW8t7XscW80zUraNi2MdrQmXzLOJ6ovwl3ZLCzFskVUNiRLWMdKPoCCtVd2P6pDsUEX9s=
Message-ID: <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com>
Date: Thu, 2 Feb 2006 13:44:05 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200602022131.59928.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602022038.16262.nigel@suspend2.net>
	 <20060202104750.GC1884@elf.ucw.cz>
	 <200602022131.59928.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> It's not an option because I'm not trying not to step all over your codebase,
> because I'm not moving suspend2 to userspace and because it doesn't make
> sense to add another layer of abstraction by sticking /dev/snapshot in the
> middle of kernel space code. There may be more reasons, but I haven't looked
> at the /dev/snapshot code at all.

Any technical reasons why suspend modules shouldn't be in userspace? I
can understand that you're not keen on redoing them but that's not an
argument for inclusion in the mainline.

                                Pekka
