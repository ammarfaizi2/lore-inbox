Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbWEQNoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbWEQNoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWEQNoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:44:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:19342 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932552AbWEQNn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:43:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lJryaaIgm/2W/zggwYan0oiOOiFWocLyUVYbSBCQ3QhF4GoKSsAD/0gGZQPJ/2EXhlFWbxnylFg+OsE26WJ31taWprjB5kUXde5OV/1QF8Ik/Fhn7XRR2iVpYwdQOzYU4ZfukXmQ46RgF13qiOpIVORuYHRrn1Nas8kL/on+cOI=
Message-ID: <3b0ffc1f0605170643t4558386ex35c02de169b5b205@mail.gmail.com>
Date: Wed, 17 May 2006 09:43:58 -0400
From: "Kevin Radloff" <radsaq@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA updated patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147873096.10470.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147796037.2151.83.camel@localhost.localdomain>
	 <3b0ffc1f0605161303paabdbfk56fe91e4156fe085@mail.gmail.com>
	 <3b0ffc1f0605170558h5072b407pa4127abe3743553f@mail.gmail.com>
	 <1147873096.10470.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2006-05-17 at 08:58 -0400, Kevin Radloff wrote:
> > Okay, I was wrong. :( Sometimes the IDE adapter doesn't resume after
> > unsuspending (suspend to RAM) or something like that. Whatever is
> > happening the disks are inaccessible though, so it's hard to get the
> > exact details.
>
> Linux does not support suspend/resume with any kind of IDE disk, PATA or
> SATA. It happens to work for many cases. Full suspend/resume support is
> on its way and some of it should be in 2.6.18 or so.

Ah.. Should I not bother investigating the regression and just wait instead? :)

-- 
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
