Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVKVQyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVKVQyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVKVQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:54:13 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:2060 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965001AbVKVQyM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:54:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BtU5KCL3QIEf7dpiSy06D5LS2NgwOX85LFpjGELaBkkXBPAOML+4ut3VDUOAceo/iQkS7iCWHy0Wd6p4PnSahv0EAsNXAGvijOp6PzYT8llLkEL/JwwBNFL4he+FZjkhpR+gU9fch0crE1Nad2sfApCEFQ4hvmmuGcQ0sqHDVyM=
Message-ID: <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
Date: Tue, 22 Nov 2005 11:54:10 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Small PCI core patch
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132616132.26560.62.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> For those who haven't noticed, the latest generation of ATI cards have a
> new 2D engine that is completely different from the previous one and
> totally undocumented. So far, they haven't showed any plans to provide
> any kind of documentation for it, unlike what they did for previous
> chipsets, not even 2D and not even under NDA. That means absolutely _0_
> support for it in linux or X.org except maybe with some future version
> of their binary blob, and _0_ support for it for any non-x86
> architecture of course.

Are you sure it is a new 2D engine? ATI engineers have mentioned
several times that they were looking at removing the 2D engine and
going 3D only - using the 3D engine to draw the 2D data.

Removal of the 2D engines is a key vulnerability in the strategy of
only using 2D on Linux.

--
Jon Smirl
jonsmirl@gmail.com
