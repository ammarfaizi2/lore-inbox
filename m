Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWEYXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWEYXBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWEYXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:01:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:7336 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965075AbWEYXBj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:01:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=S6YId3SkC0K8skYsFimpbU/qmJO8BQrryfN1WDJ6KJHOOld6nLL7riXlnA4QiB/q0dT5JDIo9F/2jvy1t41qQAy3x+TYnLWrlt8VgSe1hnIOkric4igc4cLFX6FOySPWwKfz2Hhlg8bOgU3aBTEXinDLf40BxCEEiPF2zrdVll4=
Date: Fri, 26 May 2006 01:00:41 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: dev@opensound.com, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-Id: <20060526010041.6f9ecde7.diegocg@gmail.com>
In-Reply-To: <1148596163.31038.30.camel@mindpipe>
References: <e55715+usls@eGroups.com>
	<1148596163.31038.30.camel@mindpipe>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 25 May 2006 18:29:22 -0400,
Lee Revell <rlrevell@joe-job.com> escribió:

> I'd really like to see a distro-agnostic way to retrieve the kernel
> configuration.  /proc/config.gz has existed for soem time but many
> distros inexplicably don't enable it.

/proc/config.gz takes a bit of memory, and wasting such memory when
you can store the config at /boot/config-`uname -r` is a bit weird.
