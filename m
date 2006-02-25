Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932647AbWBYAks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWBYAks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWBYAks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:40:48 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:38928 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932647AbWBYAkr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:40:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fEzaCqex9Mj/Uw2gAtJ3iM0LU/HgwZ6nKx9BVTBeefWBKj1eoLA30pwzUFaqmzKqE3uePLxtyetQau+/TeXzRuy9TisnRJajNRfsaz95LaQthSEWQZrPBaIBDiDxIfcQ8QFyPE6B6bTX+1JFGAC3aj3TE5aSDfU3kI8qUgE5WFA=
Message-ID: <5be025980602241640o84878ddy87fa8027b5cc6be5@mail.gmail.com>
Date: Fri, 24 Feb 2006 19:40:46 -0500
From: "Wei Hu" <glegoo@gmail.com>
To: "Hareesh Nagarajan" <hnagar2@gmail.com>
Subject: Re: Looking for a file monitor
Cc: "Diego Calleja" <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <43FF3C1C.5040200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>
	 <43FEBE83.6070700@gmail.com>
	 <20060224130543.f5b46bcf.diegocg@gmail.com>
	 <43FF3C1C.5040200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, that's basically what I'm looking for.
So is it correct that I can keep track of all the actions as inotify events?


> But if we want to keep a track of all the files that are opened, read,
> written or deleted (much like filemon; ``Filemon's timestamping feature
> will show you precisely when every open, read, write or delete, happens,
> and its status column tells you the outcome."), we can write a simple
> patch that makes a note of these events on the VFS layer, and then we
> could export this information to userspace, via relayfs. It wouldn't be
> too hard to code a relatively efficient implementation.
>
> Hareesh
>
