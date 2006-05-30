Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWE3Xz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWE3Xz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWE3Xz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:55:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:1284 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932240AbWE3Xz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:55:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsXKvuSWBKJa9gqilJb3wYTV1tqgDlJbEj6eIzr4xQnZ4p3sDuJiv5y8qbCYUv4gV9QEmsso1odk8xRn/ACbnJa5ZwqesYGb/39tZew7Co+PHGLOfXMVPmYdyf2lXJpPzjMu5MXRivh880EjUzp3zUAcMpL/gOQK9c6a5XrdaL0=
Message-ID: <9e4733910605301655k52dd042dlf8ebad37866c80dc@mail.gmail.com>
Date: Tue, 30 May 2006 19:55:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <20060530233813.GC16521@fooishbar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200605280112.01639.dhazelton@enter.net>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
	 <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
	 <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com>
	 <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com>
	 <20060530233813.GC16521@fooishbar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Daniel Stone <daniel@fooishbar.org> wrote:
> On Tue, May 30, 2006 at 07:27:25PM -0400, Jon Smirl wrote:
> > On 5/30/06, Dave Airlie <airlied@gmail.com> wrote:
> > >Actually the suspend/resume has to be in userspace, X just re-posts
> > >the video ROM and reloads the registers... so the repost on resume has
> > >to happen... so some component needs to be in userspace..
> >
> > I'd like to see the simple video POST program get finished.
>
> http://archive.ubuntu.com/ubuntu/pool/main/v/vbetool/

I am aware of that tool and I have looked at the source. The new
program being discussed is very similar with adjustments for using the
klibc, emu86, kernel ROM support, etc. Switching to emu86 is important
to making the tool work on PPC machines. I don't know if BenH started
with vbetool source or source from another similar tool from Scitech.
I know he was looking at both of them.

-- 
Jon Smirl
jonsmirl@gmail.com
