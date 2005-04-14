Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVDNRZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVDNRZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDNRZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:25:41 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:11133 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261557AbVDNRZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:25:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C2k6AMnBy8knHvKBvkdgQaUbhVH5arUatFsks36KH+0IZ3g5Kbfg1KRNVHPLRrxI7CdRj4B4vbY0OatQLife6Fn+9JJw1M931QGLWOecpTrdJzW4Jaix3gWmLjywKKfD4I14mOp4FTBqaUheza5RDZTp5yrfHTdlPWdTwOQBTjU=
Message-ID: <8783be66050414102551698d86@mail.gmail.com>
Date: Thu, 14 Apr 2005 13:25:35 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Dave Jones <davej@redhat.com>, Ross Biro <ross.biro@gmail.com>,
       Andi Kleen <ak@muc.de>, Ross Biro <rossb@google.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
In-Reply-To: <20050413232826.GA22698@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de>
	 <8783be66050412075218b2b0b0@mail.gmail.com>
	 <20050413183725.GG50241@muc.de>
	 <8783be66050413160033e6283d@mail.gmail.com>
	 <20050413232826.GA22698@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/05, Dave Jones <davej@redhat.com> wrote:

> If we have a situation where we screw a subset of users with the
> config option =y and a different subset with =n, how is this improving
> the situation any over what we have today ?

This is exactly the case and this is better than what we have today
because it makes it easy to chose =y or =n, so rather than making
things work for subset 1 and screwing subset 2. Each distro can chose
which subset to screw by default and make it easy for them to unscrew
themselves.

Just to be clear, we can have two users A and B with the exact same
hardware.  A setting of  =y will screw user A and a setting of =n will
screw user B.  Ideally, they would both get better hardware, but that
is not always an option.

    Ross

    Ross
