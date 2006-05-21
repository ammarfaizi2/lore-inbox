Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWEUBaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWEUBaM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 21:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWEUBaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 21:30:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:30069 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964865AbWEUBaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 21:30:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=re5qgAotWbT5kI6yvI0BbCS4FM1/EXNt5/VSnQr2JAGnUId3s4qdaQYxyoaQNt3NBHeR16ogALr30Zw2KCEaPYYkFPdhRwVIlsUnnvhWugD1Y/FEEeSSkiHpUhyQYk9zReCzwOrzMdohc5eX1i9zAfb+g7v+dPYtL5bJ06sT28I=
Message-ID: <bda6d13a0605201830x1aa4cb81m95a52bb91ab51ebb@mail.gmail.com>
Date: Sat, 20 May 2006 18:30:08 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
In-Reply-To: <446FB6F2.7040803@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
	 <446FB6F2.7040803@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/06, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
> Sanjoy Mahajan wrote:
> > That seems likely, thanks for the pointer: Besides the ACPI sleep
> > hangs, this machine (TP 600X) has fan troubles upon S3 resume.  The
> > problems don't do harm (the damn fan keeps turning on when it
> > shouldn't), but that's probably chance.  Various patches that I tested
> > for S3 resume hangs reversed this fan behavior, making the fan refuse
> > to turn on when it should have.  The same problem happened after
> > resume from swsusp (bugzilla #5000).
>
> Please try kernel 2.6.16.17 (just released). It has the SMBus fix which
> may fix resume and fan behaviour.

Am I the only person who read that as 2.6.17 the first time around?
