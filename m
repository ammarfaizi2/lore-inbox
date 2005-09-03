Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVICU3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVICU3t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 16:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVICU3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 16:29:49 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:41508 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751100AbVICU3s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 16:29:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fa2oa0iYi4qW53L+WGVp4aQJd7oiFXNim3U2Z+qPg7IEnjLIUCPhSkd+tZrJUOgdIJvPz70aqqY8CL0bnw4fMQKvj3PxXf+VV+eQ4LOsnTqUMacWb6dlCUkCmkvZchTyrIxVM8lPzgporT5QUoUpQzNjQDrPXboa4327OGb/j/o=
Message-ID: <81b0412b05090313296bcd2a85@mail.gmail.com>
Date: Sat, 3 Sep 2005 22:29:42 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: Re: forbid to strace a program
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfc1cb$4na$1@pD9F86CED.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dfc1cb$4na$1@pD9F86CED.dip0.t-ipconnect.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/05, Andreas Hartmann <andihartmann@01019freenet.de> wrote:
> Hello!
> 
> Is it possible to prevent a program to be straced on x86?
> What do I have to do, eg., to prevent a perl-program to be straced?
> 

So that none can see what are you doing? Or because your program is
breaking because of this? Probably nothing, but someone would like
to know what it is you are doing and exactly how it breaks (and, if
you don't mind -
why it breaks).

Actuall, you can prevent a program of being straced (or debugged, for
that matter):
run it as another user. Root still can strace anything, though.
