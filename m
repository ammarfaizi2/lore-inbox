Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUJUMJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUJUMJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268565AbUJUMI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:08:56 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:48428 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268703AbUJUMGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:06:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lpHLnTC/ZP7QWGM0GxXxPyXWZQkEQmrT2F6HzW6OUZXkBYh+64K8dkkoBzer+wjadMbXjrE8LSozybtzBsSBuacgxXG6ZfaQUey5kMy1zH9XMPRD31iSjlMkkPbpoue1csgx9+91/CuWU+ZBU01sHyneS5nkZvqP5rYrTb7zBwU=
Message-ID: <e796392204102105063fca80f@mail.gmail.com>
Date: Thu, 21 Oct 2004 14:06:45 +0200
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: cijoml@volny.cz
Subject: Re: Hibernation and time and dhcp
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410202045.24388.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410202045.24388.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hibernate.conf:

### clock
SaveClock yes


OnResume 20  dhcpcd -n



On Wed, 20 Oct 2004 20:45:24 +0200, Michal Semler <cijoml@volny.cz> wrote:
> Hi guys,
> 
> with 2.6.9 hibernation to disk finally works! Thanks
> To ram it still don't work, system starts with lcd disabled - but it is
> another story.
> 
> I have now this problem - when I hibernate and then system is started up in
> other company, it don't update time and shows still for example 14:00 - when
> I rehibernate for example in 20:00 - could you ask bios for current time?
> It's better to have bad time about few seconds instead of hours.
> 
> Same problem with dhcp - it should ask for IP when rehibernate.
> 
> Thanks for fixing
> 
> Michal
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
