Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281591AbRKWIdP>; Fri, 23 Nov 2001 03:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281812AbRKWIdF>; Fri, 23 Nov 2001 03:33:05 -0500
Received: from kiln.isn.net ([198.167.161.1]:8472 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S281811AbRKWIcu>;
	Fri, 23 Nov 2001 03:32:50 -0500
Message-ID: <3BFE099F.52BB7006@isn.net>
Date: Fri, 23 Nov 2001 04:32:31 -0400
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2fsck-1.25 problem
In-Reply-To: <3BFDBB15.AD778DA4@isn.net> <20011122211827.T1308@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is solved. fsck was dependent on libgcc_s.so.1, which had no
execute permissions. Don't know how that happened. It was also on
/usr/local/lib on another partition and I moved it to /lib
Thanks Andreas
 Garst
