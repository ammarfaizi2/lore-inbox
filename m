Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbULaRtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbULaRtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbULaRtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:49:23 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:37914 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262136AbULaRsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:48:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bbKDe6KwHgSEK/6tRzJ37p9CL2EHeHDDEL3B9YRzMBVvglA1AD7LP6t9YoscJnFhGFZSM8AUqETOZsLgSS4QxCpID4wWieFYZw1tf+GCvn7k0kYUXoLBikowuGlnlEZ50aBaq83iB6Cyt3K7wmEjvFp+ABJ+4jgb+1cPYnW39t0=
Message-ID: <2b8348ba041231094816d02456@mail.gmail.com>
Date: Fri, 31 Dec 2004 09:48:41 -0800
From: Ush <ofeeley@gmail.com>
Reply-To: ofeeley@gmail.com
To: William <wh@designed4u.net>
Subject: Re: the umount() saga for regular linux desktop users
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412311741.02864.wh@designed4u.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412311741.02864.wh@designed4u.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 17:41:02 +0000, William <wh@designed4u.net> wrote:
 
> Regularly, when attempting to umount() a filesystem I receive 'device is busy'
> errors. The only way (that I have found) to solve these problems is to go on
> a journey into processland and kill all the guilty ones that have tied
> themselves to the filesystem concerned.

Even a lazy umount doesn't work?  "umount -l <filesystem-name>"

> In my opinion, in order for linux to be trully user friendly, "a umount()
> should NEVER fail" (even if the device containing the filesystem is no
> longuer attached to the system). The kernel should do it's best to satisfy
> the umount request and cleanup. Maybe the kernel could try some of the
> following:

Would it be user-friendly if this forcible umount caused the user to lose data?

Oisin
