Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbTCRIOO>; Tue, 18 Mar 2003 03:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbTCRIOO>; Tue, 18 Mar 2003 03:14:14 -0500
Received: from sheridan.uel.ac.uk ([161.76.9.2]:10942 "EHLO sheridan.uel.ac.uk")
	by vger.kernel.org with ESMTP id <S262303AbTCRION>;
	Tue, 18 Mar 2003 03:14:13 -0500
Date: Tue, 18 Mar 2003 08:25:02 +0000
From: fs <admin@www0.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4 config giving -march=athlon for all athlons/durons
Message-ID: <20030318082502.GA21350@www0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if it's on 2.5 too, but, giving duron/athlon on the cpu type it
passes -march=athlon on gcc. Some athlons had no sse support when
e.g. -march=athlon-4 can be used for new amd cpus that have sse support.

For a duron 1.3 here, that shows sse on cpuinfo, passed march=athlon-4
on the arch Makefile, having no problems after two weeks uptime with
that kernel.

Are there any issues covering this detail or it's just not right?

- fs
