Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281369AbRKTUls>; Tue, 20 Nov 2001 15:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281373AbRKTUli>; Tue, 20 Nov 2001 15:41:38 -0500
Received: from cs314333-a.mtnk1.on.wave.home.com ([24.101.65.215]:59305 "HELO
	misato.prohost.org") by vger.kernel.org with SMTP
	id <S281369AbRKTUlZ>; Tue, 20 Nov 2001 15:41:25 -0500
Date: Tue, 20 Nov 2001 15:45:34 -0500
From: hackie@misato.prohost.org
To: linux-kernel@vger.kernel.org
Subject: Unkillable process in 2.4.15-pre5
Message-ID: <20011120154534.A30266@misato.nerv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using boarland's kylix 2 open edition,

as soon as it is started just run the default project (it's starts with this
project by default), then go into debugging, and while there terminate
kylix, it leaves its [Project1] process which is in

$ cat /proc/31366
31366 (Project1) R 1 31365 31365 0 -1 1092 0 0 0 0 2 2 0 0 11 1 0 0 14864708 0 0 4294967295 0 0 0 0 0 0 65536 0 0 3222391056 0 0 17 0

state, I can't SIGKILL it (it's in RWN state as ps says it).
