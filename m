Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310828AbSCMQ5F>; Wed, 13 Mar 2002 11:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310827AbSCMQ45>; Wed, 13 Mar 2002 11:56:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8708 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310821AbSCMQ4s>; Wed, 13 Mar 2002 11:56:48 -0500
Subject: Re: proc/stat question
To: dana.lacoste@peregrine.com (Dana Lacoste)
Date: Wed, 13 Mar 2002 17:12:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2CE8@ottonexc1.ottawa.loran.com> from "Dana Lacoste" at Mar 13, 2002 08:34:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lCIi-0006tl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fine.  On systems with 2 IDE disks (hda and hdc) it only shows hda's info.
> on systems with the compaq smart array controller, i get nothing.

Yeah - its old stuff, and its a bit limited. Take a look at /proc/partitions
in a currentish -ac kernel. That has the sard stuff that Red Hat did finally
merged into it
