Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136008AbRDVKDj>; Sun, 22 Apr 2001 06:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136010AbRDVKDT>; Sun, 22 Apr 2001 06:03:19 -0400
Received: from quechua.inka.de ([212.227.14.2]:29244 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S136004AbRDVKDJ>;
	Sun, 22 Apr 2001 06:03:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010421114942.A26415@thyrsus.com> <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Organization: private Linux site, southern Germany
Date: Sun, 22 Apr 2001 11:33:17 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14rGF3-0003wH-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is nice to have a single file for grep. With the proposed
> changes one would sometimes need to grep every file.

With the proposed changes it's nearly trivial to build the traditional
MAINTAINERS file with a Makefile rule, so you've lost nothing. Plus
you get the additional info (which the collecting script, two lines of
sed in my estimate, would duly include[1]) which _file_ actually is
maintained by whom.

Which makes e.g. coordinating patches and bug reporting much easier.

Olaf

[1] Although Eric would probably rather want to use a database
querying tool at this point :-)
