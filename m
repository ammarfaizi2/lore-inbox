Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVJEVLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVJEVLl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVJEVLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:11:40 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:5582 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965114AbVJEVLj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:11:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UEnLBgfpMUGUSrFMKZD+SiwiawbyGYspnfvlchXhT5R5aY4T7gYeJEUKQE62ezbrLZtc3En4EZ2TDP18p24ShNuqQelsJq0JAxi4Tf7mA+PbIvs+wlqz4z/NxFvYdnQXv3zsceUaPpHF9KcQxKYVMvb9knCYZcVi3gY5qcY121E=
Message-ID: <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>
Date: Thu, 6 Oct 2005 07:11:36 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: Why no XML in the Kernel?
Cc: Al Viro <viro@ftp.linux.org.uk>, jonathan@jonmasters.org,
       Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87zmpqbcws.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	 <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	 <87oe66r62s.fsf@amaterasu.srvr.nix>
	 <20051003153515.GW7992@ftp.linux.org.uk>
	 <87zmpqbcws.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> (Current rant: DRM churn, forcing one of abandonment of decent 3D
> support, or upgrading of the X server to the bleeding-edge, or using an
> old kernel with known security holes, or becoming enough of a DRI
> developer to backport the changes, or using nothing but distro kernels
> <=2.6.11. Most of these are not terribly feasible for me right now. Ah
> well, my 3D card is total crap anyway. It's just a shame the X server
> crashes whenever asked to do in-software 3D rendering...  time to
> debug. I thought I might actually get some work done this evening. Fat
> chance.)

This is just mach64, we don't have mach64 support in the kernel so it
has nothing to do with the kernel... I've no idea why mach64 broke but
upgrading everything won't fix it.. the kernel-drm and userspace do
not need to be kept in any sort of lockstep, and the mach64 dri code
hasn't been touched by anyone in > 1 year probably even two.. (I was
last person to own one to test it on...)

If you could nail down exactly when it went south then we can fix
it... but giving out here won't help anyone..

Dave.
