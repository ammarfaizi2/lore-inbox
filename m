Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTBRPya>; Tue, 18 Feb 2003 10:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267862AbTBRPy3>; Tue, 18 Feb 2003 10:54:29 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:1732 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267892AbTBRPyJ>; Tue, 18 Feb 2003 10:54:09 -0500
Date: Tue, 18 Feb 2003 11:01:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: why is "scripts/elfconfig.h" not removed with "make mrproper"?
Message-ID: <Pine.LNX.4.44.0302181059210.15334-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i just verified that the original 2.5.62 kernel tree does not
start with the header file "scripts/elfconfig.h".  this file is
created by running "make xconfig", even when nothing is configured.
but that file is *not* removed by running "make mrproper", which
i would think it should be.

  won't this cause a problem when generating patches, since
that elfconfig.h file will show up every time?

rday


