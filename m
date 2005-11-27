Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVK0C1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVK0C1j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 21:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVK0C1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 21:27:39 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:37906 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750821AbVK0C1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 21:27:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=phMYqJcqtLfpkcuu7WdXYMyS5j6JSIoK0BvNCaD6Xgo+XgR1KP/Q9ekImGMNzoUi2RR5K7kdoilwLyX2UGLqvrGVZQad9MBDNnVncSEo4KZWF9Oe99vE98YppOB3Yj3yaGiyJlT2lTLjqTYmbNUuNmhMAQC8zAImrYjGyz4GTTk=
Message-ID: <29495f1d0511261827s7984bea8l92149b8a3091e6d8@mail.gmail.com>
Date: Sat, 26 Nov 2005 18:27:38 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
	 <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
	 <200511270151.21632.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261756r65d0f4b7l96b0e1089c4c62bc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/05, David Brown <dmlb2000@gmail.com> wrote:
> > Thanks Nish, this is obviously the difference. I never compile anything as
> > root (pesky Makefiles rm -rf'ing things!).
>
> Yeah, but you still need to install stuff as root... unless you do
> weird stuff like installwatch or something.

Uh, untarring is the operation that needs to be non-root. So just have
a build user or some other non-root user do the untarring and building
(which is recommended by most anyways, IIRC). Then, as root (or via
sudo) make modules_install install.

On 11/26/05, David Brown <dmlb2000@gmail.com> wrote:
> Yeah you can't very well compile and install a kernel without
> permissions to /boot ;)

Again, you pretty clearly can *compile* a kernel as boot. root is only
needed for install (and this is the division of tasks that I use and
recommend to others).

Thanks,
Nish
