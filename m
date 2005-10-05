Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbVJEW52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbVJEW52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbVJEW52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:57:28 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:21802 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030416AbVJEW51 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:57:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epWyDJOHGLPXi60kJO3jRDipX8oh6FJ2PpkP/O0qzb9yNWbGp3mKIqXQM5TF9Rk8jdez2PM5SkOj2nWqDHZD1AUwEZdWj0NMsaiUiRK6zTQNIcmVwb7IrOQCrdLR2+ZuTF1NdnUvn7NVAfX8CTMmrxOpeeTru/gI9tdETtDtTRQ=
Message-ID: <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>
Date: Thu, 6 Oct 2005 08:57:26 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: Why no XML in the Kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87br23odls.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	 <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	 <87oe66r62s.fsf@amaterasu.srvr.nix>
	 <20051003153515.GW7992@ftp.linux.org.uk>
	 <87zmpqbcws.fsf@amaterasu.srvr.nix>
	 <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
	 <87br23odls.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > This is just mach64, we don't have mach64 support in the kernel so it
> > has nothing to do with the kernel... I've no idea why mach64 broke but
>
> I misspoke. Some of the non-DRM API changes around 2.6.12 broke the
> 6.8.2 mach64 module in DRI CVS; the development version builds again,
> and nearly works.
>

But that's my point if you had a previously working mach64 with 6.8.2
with a DRM from around then, and a kernel upgrade broke the DRM you
should be just able to upgrade the DRM to the latest DRM CVS, there
isn't any such thing as a 6.8.2 DRM, you'll only cause much more
issues trying to fix an issue in the kernel side by also
simultaneously upgrading userspace... as you've no fixed working point
to try from..

The mach64 drm is in CVS on cvs.freedesktop.org:/cvs/dri and the module is drm..

Dave.
