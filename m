Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSEaWI6>; Fri, 31 May 2002 18:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSEaWI5>; Fri, 31 May 2002 18:08:57 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:48001 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S316958AbSEaWI4>; Fri, 31 May 2002 18:08:56 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200205312208.g4VM8unD001714@twopit.underworld>
Subject: linux-2.4.19-pre9-ac3: PnPBIOS crash
To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2002 23:08:56 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a dual PIII machine with 1.25 GB of RAM, and I have just
installed a 2.4.19-pre9-ac3 kernel. (I also have ALSA CVS and lm
sensors 2.6.3 installed.)

Anyway, I decided to compile in the PNPBIOS feature and discovered
that:

# cat /proc/bus/pnp/escd

is a synonym for "cold reboot". Now I understand that *writing* to
random /proc files is a Bad Thing, but reading them??? I would have
thought that the worst I could have done would have been corrupting my
termininal. Is the escd file my actual ESCD area?

Is this a bug, or just a case of "don't do that!"?

Cheers,
Chris
