Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270614AbTGNOi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270631AbTGNOiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:38:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21195 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270614AbTGNOga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:36:30 -0400
Date: Mon, 14 Jul 2003 11:48:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre5 deadlock
In-Reply-To: <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva>
 <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk>
 <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Jul 2003, Jim Gifford wrote:

> I started linux-2.4.22-pre5 at 1:00am it stopped at 8:00am, with no error
> messages. I did enable sysrq keys here is the information.

Jim,

Can you please use ksymoops and your System.map to convert the backtraces
to human readable format?

You're not using quota, so you are not hitting the quota/ext3 deadlock.

