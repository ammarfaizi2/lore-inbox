Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSAFLQr>; Sun, 6 Jan 2002 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSAFLQh>; Sun, 6 Jan 2002 06:16:37 -0500
Received: from dialin-145-254-131-080.arcor-ip.net ([145.254.131.80]:9220 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S287827AbSAFLQc>;
	Sun, 6 Jan 2002 06:16:32 -0500
Date: Sun, 6 Jan 2002 12:16:29 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: reiserfs over nfs export problems
Message-ID: <20020106121629.A244@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i've tried to export a reiserfs volume over nfs (knfsd).
First kexportfs fails with "invalid argument", and mounts
are failing with a "reason given by server: Permission denied".
All subsequent exports succeeded.

The same is in 2.4.18-pre1. 2.4.17 looks ok.
I suspect that unexport everything before first export
could also make it work properly. 

-alex
