Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131838AbRCUXmP>; Wed, 21 Mar 2001 18:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131837AbRCUXmG>; Wed, 21 Mar 2001 18:42:06 -0500
Received: from mail.gci.com ([205.140.80.57]:2312 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S131836AbRCUXlw>;
	Wed, 21 Mar 2001 18:41:52 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446D546@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Eli Carter <eli.carter@inet.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Prevent OOM from killing init
Date: Wed, 21 Mar 2001 14:41:05 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick O'Rourke, who wrote:
> Since the system will panic if the init process is chosen by
> the OOM killer, the following patch prevents select_bad_process()
> from picking init.
> 

(Patch deleted)

What happens when init is not pid == 1, as is often the case
during installs, booting off of cdrom, etc..

