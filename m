Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVCIF6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVCIF6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVCIF6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:58:24 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:39477 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261540AbVCIF6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:58:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VaCz6JWkCrH96T1EwSgYV8gAcWIZPjD43XtKjQQUI4ey/mx8CUY5cCBkjHysKtF2/QhQioIzwUIfQqVq0OUPDn6ugMSirFcM1RwG3G6j4KEavFeqZoW9Rb367sHx43wnju3U/45QNT+xtXw04AIPWLo/DigaO6JgGfx62xlDLik=
Message-ID: <9e4733910503082158c95c904@mail.gmail.com>
Date: Wed, 9 Mar 2005 00:58:20 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110346634.32556.54.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
	 <1110326565.32556.7.camel@gaston>
	 <9e47339105030819172eecc324@mail.gmail.com>
	 <1110340398.32557.36.camel@gaston>
	 <9e4733910503082035318e9d23@mail.gmail.com>
	 <1110346634.32556.54.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005 16:37:13 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2005-03-08 at 23:35 -0500, Jon Smirl wrote:
> > This is from /linux-2.5/Documentation/filesystems/sysfs-pci.txt. It
> > describes how ia64 is achieving legacy IO.  The VGA control code
> > probably needs to be coordinated with this.
> 
> This is a different thing, and I will implement it on ppc one of these
> days. This is for issuing the IO cycles on the bus. It has nothing
> to do with the actual arbitration work.

Each one of these legacy spaces corresponds to an allowable
simultaneous VGA use. There should be one arbiter per legacy space.

-- 
Jon Smirl
jonsmirl@gmail.com
