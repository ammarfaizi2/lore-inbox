Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJRPmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJRPmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVJRPmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:42:10 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:58768 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbVJRPmI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:42:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dSsaWOyFDlTjqLHnxPhHnI2pJferJjFYnevOeoWg9VDInhba+bdn1I5dYb6Sdu9v5qXcYLcUzWty04zX8qdfqoT7axWOHhKcRfFk6mi0P09+jVgeN3vogi4yLWj4NEuvzhnaIWXjeHZMGs8sf+1OVsJVrGP+hhZSGpT6dvN4gnc=
Message-ID: <b6c5339f0510180842md8ff1d9v84780cde7c6bf58a@mail.gmail.com>
Date: Tue, 18 Oct 2005 11:42:07 -0400
From: Bob Copeland <email@bobcopeland.com>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: file system block size
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Roushan Ali <roushan.ali@gmail.com>,
       Nathan Scott <nathans@sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1129649424.23632.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <30b4e63b0510172252x1dfca9f2l75bb0f183aecf7bb@mail.gmail.com>
	 <20051019001218.B5830881@wobbly.melbourne.sgi.com>
	 <1129646212.15136.37.camel@imp.csi.cam.ac.uk>
	 <b6c5339f0510180812p3ff6d0b1ia204b28c4e50186d@mail.gmail.com>
	 <1129649424.23632.55.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/05, Badari Pulavarty <pbadari@gmail.com> wrote:
> On Tue, 2005-10-18 at 11:12 -0400, Bob Copeland wrote:
> > That, and the extent-supporting mpage_readpages would make me a happy person.
>
> Can you elaborate ? What would you like to see in mpage_readpages() ?
> Christoph recently posted patches to add support for getblocks() in
> mpage_readpages().  What else do you need ?

Yes, that is exactly what I was referring to.  I think Christoph's
patch will work great for my fs but I haven't had a chance to try it
out yet.

-Bob
