Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRCPMrA>; Fri, 16 Mar 2001 07:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCPMqv>; Fri, 16 Mar 2001 07:46:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59028 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129282AbRCPMqm>;
	Fri, 16 Mar 2001 07:46:42 -0500
Date: Fri, 16 Mar 2001 13:45:35 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103161245.NAA00944.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, rhw@MemAlpha.CX
Subject: Re: [PATCH] Improved version reporting
Cc: kaboom@gatech.edu, linux-kernel@vger.kernel.org, seberino@spawar.navy.mil
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Riley Williams <rhw@MemAlpha.CX>

    Neither am I - but, according to comments from RedHat a while back,
    they repackage mount separately because they provide a NEWER version
    of mount than is in the util-linux package. This will ALSO result in
    `mount --version` giving the wrong answer...

There is no newer version.
In ancient times I came with frequent releases of mount, at a time
when util-linux was released very infrequently. These years mount
is part of util-linux, and util-linux is released frequently.

    Unless one can guarantee that the util-linux and mount packages are
    the SAME version, mount can't be guaranteed to report the version of
    the util-linux package installed. RedHat provide a NEWER version of
    mount to util-linux so that guarantee doesnae exist.

I do not think they do.

     > You are mistaken, as is proved by the reports that contain a kbd
     > line: a grep on linux-kernel for this Februari shows people with
     > Kbd 0.96, 0.99 and 1.02.

    {Shrug} Please explain why I was unable to get ver_linux to report a

When other people can and you cannot, why should I explain your failure?
Let me just check. A version from 1993:

  % ./loadkeys -h 2>&1 | head -1
  loadkeys version 0.81

A version from 2001:

  % ./loadkeys -h 2>&1 | head -1
  loadkeys version 1.06

Maybe nothing has changed here the past eight years. It just works.
Perhaps you tried some modified version.

Andries
