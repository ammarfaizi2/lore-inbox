Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288083AbSA3Ccf>; Tue, 29 Jan 2002 21:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288102AbSA3CcZ>; Tue, 29 Jan 2002 21:32:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17677 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288092AbSA3CcT>; Tue, 29 Jan 2002 21:32:19 -0500
To: linux-kernel@vger.kernel.org
From: hpa@transmeta.com (H. Peter Anvin)
Subject: master.kernel.org situation update
Date: 29 Jan 2002 18:31:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a37lu4$q5a$1@tazenda.transmeta.com>
Reply-To: hpa@zytor.com (H. Peter Anvin)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The situation on master.kernel.org is looking pretty grim.  We were
trying to add disk capacity (the host uses a DAC960PRL RAID
controller) and the end result seems to be that a Mylex utility called
"ezsetup" has completely trashed the RAID configuration information.
What makes matters worse is that an MIS screwup here means no backups
have been running for a month or so.

Clearly, the archive section of the system is mirrored, and therefore
recoverable, but there are lots of scripts and anything else that
involves automation that may be lost if we cannot recover this data.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
