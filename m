Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291293AbSAaUwc>; Thu, 31 Jan 2002 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291287AbSAaUwW>; Thu, 31 Jan 2002 15:52:22 -0500
Received: from quechua.inka.de ([212.227.14.2]:14618 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S291293AbSAaUwJ>;
	Thu, 31 Jan 2002 15:52:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Memory leaks with GRE Tunnels
In-Reply-To: <3C598DE3.8090405@somanetworks.com> <CHEKKPICCNOGICGMDODJKEHPGDAA.george@gator.com>
Organization: private Linux site, southern Germany
Date: Thu, 31 Jan 2002 21:49:42 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E16WO9O-0001ZO-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <CHEKKPICCNOGICGMDODJKEHPGDAA.george@gator.com> you write:
> I wonder if this also causes a different problem ... when using CIPE
> (which is a tunnel of a different sort) if I stop a tunnel, I can not
> restart it with the same cipe device number. I get a message that the
> device is in use.  I have to unload and reload the CIPE module to be
> able to use the device numbers configured in the config file. If I

I don't think this is the same problem. The code dealing with device
allocation in CIPE is not related at all to the in-kernel stuff, as
seen from my POV. Btw. you must have a weird bug, as this has always
worked perfectly enough for me. (Perhaps your detailed config would
help figure it out.)

Olaf

