Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTJOPwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTJOPwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:52:46 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:40198 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263469AbTJOPwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:52:41 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Subject: Re: LVM Snapshots
Date: Wed, 15 Oct 2003 17:51:23 +0200
User-Agent: KMail/1.5.3
References: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7zWj/wAtd+KdNjL"
Message-Id: <200310151751.23103.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7zWj/wAtd+KdNjL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 15 October 2003 17:40, Christoph Pleger wrote:

Hi Christoph,

> I am using a 2.4.22 kernel from www.kernel.org together with an XFS
> patch from SGI. I want to use LVM for creating snapshots for backups,
> but I found out that I cannot mount the snapshots of journalling
> filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.
> My research on internet gave the result that a kernel-patch must be used
> to solve that problem, but I could not find such a patch for Linux
> 2.4.22, so where can I get it?

Marcelo decided not to apply that needed patch. Here it is for you to play 
with :) ... It'll apply with offsets to 2.4.23-pre7.

ciao, Marc

--Boundary-00=_7zWj/wAtd+KdNjL
Content-Type: application/x-bzip2;
  name="LVM-v1.0.7-2.4-22-pre9-VFS-lock.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="LVM-v1.0.7-2.4-22-pre9-VFS-lock.patch.bz2"

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
ChIeA+SzIA==

--Boundary-00=_7zWj/wAtd+KdNjL--


