Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVCZARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVCZARM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVCZARM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:17:12 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:36771 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261885AbVCZARK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:17:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UKE1Kq70wNsN341pkSEwo9yiXAV2i9HBa8q8PwRlefIGLRuafoPxrq1+FcDwFnz7qO/OVY19z+c+Z1H4aDCiAi+/tSDiEggFa6Ef5dxaxXJIqv9MMZiB5ZXt4j2WWIc9CWAIDejKcYF9UqCh2ONoF/EhcGC8T50Sbh52F8vZoSE=
Message-ID: <2a0fbc5905032516174f064e23@mail.gmail.com>
Date: Sat, 26 Mar 2005 01:17:09 +0100
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <1111792854.23430.32.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792854.23430.32.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 18:20:54 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > I also experiment sometimes a complete hang of the system. But I
> > didn't find how to reproduce the bug yet, especially because it seems
> > to happen when I do nothing (when I'm sleeping or am at work ;), and I
> > can't get a Oops because I don't have any serial console...
> 
> You could try netconsole...

Good point... I just tried, but forcedeth doesn't support netpoll. If
you have a pointer, I could try to implement it ;-)

-- 
Julien
