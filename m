Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSILOrl>; Thu, 12 Sep 2002 10:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSILOrl>; Thu, 12 Sep 2002 10:47:41 -0400
Received: from 62-190-219-3.pdu.pipex.net ([62.190.219.3]:27915 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316070AbSILOrl>; Thu, 12 Sep 2002 10:47:41 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209121500.g8CF0D30003216@darkstar.example.net>
Subject: Re: XFS?
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2002 16:00:13 +0100 (BST)
In-Reply-To: <200209121542.21987.martin.knoblauch@mscsoftware.com> from "Martin Knoblauch" at Sep 12, 2002 03:42:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In my opinion the non-inclosure in the mainline kernel is the most 
> important reason not to use XFS (or any other FS). Which in turn 
> massively reduces the tester base. It is a shame, because for some type 
> of applications it performs great, or better than anything else.

On the other hand, filesystem corruption bugs are one of the worst type to suffer from.  We absolutely don't want to include filesystems without at least a reasonable proven track record in the mainline kernel, and therefore encourage the various distributions to use them, incase any bugs do show up.  Look how long a buffer overflow existed in Zlib unnoticed.

EXT2 is a very capable filesystem, and has *years* of proven reliability.  That's why I'm not going to switch away from it for critical work any time soon.

John.
