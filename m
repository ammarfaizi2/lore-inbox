Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319204AbSIGQTs>; Sat, 7 Sep 2002 12:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSIGQTs>; Sat, 7 Sep 2002 12:19:48 -0400
Received: from 62-190-218-247.pdu.pipex.net ([62.190.218.247]:50952 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319204AbSIGQTr>; Sat, 7 Sep 2002 12:19:47 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209071631.g87GVoCD001390@darkstar.example.net>
Subject: Re: ide drive dying?
To: holger@lubitz.org (Holger Lubitz)
Date: Sat, 7 Sep 2002 17:31:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D7A2133.EB157AC@lubitz.org> from "Holger Lubitz" at Sep 07, 2002 05:54:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if it would be possible for the driver to monitor SMART and
> lighten the load on the drive when things don't seem normal.

I think it would be fun to have SMART monitoring in the driver, but I'm not sure it's worth the bloat.  It *can* be done in userspace, afterall.

> What is normal, anyway?

Not sure what 'normal' is, but the manufacturer defines thresholds, which are to be interpreted as 'drive is failing' if they are exceeded.

> I don't really believe the 310617 power on hours my Maxtor (the old 60
> gig with 4 platters) claims, either.

That's because it's reporting power on time in minutes :-)

John.
