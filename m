Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVE0OVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVE0OVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVE0OVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:21:41 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:65036 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261751AbVE0OVj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:21:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jhBRjYQFW/9DHlp67ducZA01n83gU6MgOXx0p9cjNUn7r7/jF7jT448/rUQobzMh0Dtq0UxsEYIG8FVtR74Cf0vO30R3pd9UF8eNwzMQJEeAR+BINBypm4gnVgMje1HTaT1A2Ad3huaAa0e0GUlQuhZTlLKqQNga8ey0auhoX0U=
Message-ID: <d120d500050527072146c2e5ee@mail.gmail.com>
Date: Fri, 27 May 2005 09:21:39 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
In-Reply-To: <4296EADA.nail3L111R0J3@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4847F-8q-23@gated-at.bofh.it>
	 <E1Db3zm-0004vF-9j@be1.7eggert.dyndns.org>
	 <4295005F.nail2KW319F89@burner>
	 <8E909B69-1F19-4520-B162-B811E288B647@mac.com>
	 <4296EADA.nail3L111R0J3@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/05, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> > I set up
> > my udev so that my green CD burner is /dev/green_burner, and my blue
> > CD burner
> > is /dev/blue_burner.  Please tell me again why exactly I can't just
> > give the
> > option -dev=/dev/green_burner and have it use my green CD burner?
> 
> Try to start with reading the cdrecord manual page. Your question
> is answered in there.....but if you issue a command that is only
> halfway correct you will never be able to get the full set of features from
> cdrtools. Using UNIX device names for SCSI devices is highly nonportable
> and for this reason not supported by a portable program like cdrecord.
> 
> Cdrecord includes the needed features to do what you like, but do not
> asume that you will be able to force me to make nonportable and Linux
> specific interfaces a gauge for the design of a portable program.
> If you read the cdrecord man page, you know that you could
> happily call cdrecord dev=green_burner.....
> 

No, that static mapping is not good. I have an external enclosure that
does firewire and USB. I want to be able to use "sony-dvd" to access
it no matter whether it is onnected to USB bus or Firewire and whether
there are other devices (disks) on USB or firewire. It is possible to
do with udev creating a link to /dev/sony-dvd.

-- 
Dmitry
