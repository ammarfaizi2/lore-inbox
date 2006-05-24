Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWEXX4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWEXX4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 19:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWEXX4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 19:56:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:33231 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932336AbWEXX4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 19:56:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s5Z49WcVcNJK6ge5A9jeNvqAEAzUC2Cd2OBuWCsjsQAqlYhBc0LaFOFst8mL+cLLf0SvE4jM22qKnegVMa6FlSWXVrVtIaaoeiW3dlGCWi7XVdTxf9P1MqcOeWNLuSvPQcW3hqtveHVA37YeVzBWeZcdSO9HiDkP3F3eeUhGOIE=
Message-ID: <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
Date: Wed, 24 May 2006 19:56:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970605241618x7eaeb010h60817b5ca944acd9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232338.54177.dhazelton@enter.net>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <200605240017.45039.dhazelton@enter.net>
	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
	 <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>
	 <21d7e9970605241618x7eaeb010h60817b5ca944acd9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Dave Airlie <airlied@gmail.com> wrote:
> It has absolutely nothing to do with the GPL vs BSD licensing on the
> code it has to do with the belief that fbdev isn't a complete enough
> model to do what needs to be done and merging it into the DRM is just
> going to make things worse rather than better, I've no idea where you
> ever came up with it being a licensing thing at all... the FreeBSD ppl
> have on interest in taking fbdev code anyways...

I got giant earfuls of the BSD issue from EricA. But, Dave, you are
more reasonable than some of the other X developers so I'm not putting
blame on you. I did notice that you didn't deny the part about zero
forward progress in the kernel.

I do stand by my opinion that building a driver bus so that three
independent drivers (fbdev, DRM, XAA/EXA) can simultaneously multitask
on a single piece of hardware is not a good design. It is a political
solution, not a technical one.

-- 
Jon Smirl
jonsmirl@gmail.com
