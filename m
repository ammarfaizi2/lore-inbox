Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWEXQPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWEXQPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWEXQPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:15:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:61800 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932359AbWEXQPJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:15:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A57XUZQM3ZEGIBtgvFn4a7flDK6okDog45jYNUBNRVyw78xTVWuQfpNxTVvy7RONmvUihbUCVZtNqds4Bk7NBRiad2HWh/fW4+TFNPo8dbqIVlygsNHDFP6e/AX7RrAZ5/OdfvfRYVXOsxS09EatOTFrVIElZShqBq7q8OzuaVo=
Message-ID: <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
Date: Wed, 24 May 2006 13:15:07 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <44747432.1090906@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com>
	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
	 <44747432.1090906@ums.usu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Alexander E. Patrakov <patrakov@ums.usu.ru> wrote:
> Jon Smirl wrote:
> > You can't change the mode, instead you have to track it and use the
> > one that is already set.
>
> OK, this doesn't change my other point: use in-kernel text output facility for
> panics only.
>

It would be a good idea to allow oopses to be shown too. For example,
your main disk controller driver may oops, and then you have no way to
tell what happened, because if you try to run dmesg it may deadlock,
and obviously the oops message wont be logged either.
So a BSOD which allows you to hit enter to continue after an oops is
not a bad idea.
