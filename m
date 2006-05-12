Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWELFHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWELFHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 01:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWELFHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 01:07:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:5650 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750908AbWELFHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 01:07:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d06h75XtOvLDgqIVUtJXfbXZW1rpsUd18g9njjgGE/WwIEfhYp7Ux47aNDAl7uZmd5BYw+KhVPtuBt0Jx4aZ2zAWvMqRg/sT0viFD/CiEE4jTk0QBr8oamMm4SmguJB88SbvBEQslhlHQn4687igD63lllsB32Op3igv+l+PQrI=
Message-ID: <9e4733910605112207t3e20218akc7b697987c47059b@mail.gmail.com>
Date: Fri, 12 May 2006 01:07:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: SecurityFocus Article
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Ed White" <ed.white@libero.it>, ML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970605112113s16764073tca5246d1e104503b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060511143440.23517.qmail@securityfocus.com>
	 <Pine.LNX.4.61.0605111140030.3833@chaos.analogic.com>
	 <9e4733910605112017u428c04cdm2ff40b53785db09c@mail.gmail.com>
	 <21d7e9970605112113s16764073tca5246d1e104503b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/06, Dave Airlie <airlied@gmail.com> wrote:
> Your ideas to fix X didn't result in patches to fix X, ideas are great
> we all have ideas, patches are better, for some reason we don't all
> have patches. We are fixing X, you are not.

In the past I wasted way too much time writing patches for X. I
understand now that there is little consensus on where X is going in
the future. X has few resources and many of these resources work at
cross purposes. You are doing a fine job, please keep up the good
work. For my part I have chosen to stop working in such a chaotic
environment.

But, no matter how you slice it, X is still a multi-megabyte process
needlessly running as root which makes it a scary security issue. I
know you are already aware of the philosophical and architectural
changes needed to switch X to a model where it runs as a normal
process and relies on the kernel for privileged operations. You and
Ian are taking the first steps, I hope that X will reach the consensus
necessary to implement the full change.

Question my sanity if you want, but I'm sticking with the old fashion
idea that privileged code that mucks with hardware belongs in a device
driver. I'm also stuck on the radical idea that only one device driver
at a time should be in control of a piece of hardware. X violates both
of these.

-- 
Jon Smirl
jonsmirl@gmail.com
