Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSKGPu1>; Thu, 7 Nov 2002 10:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSKGPu1>; Thu, 7 Nov 2002 10:50:27 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:19368 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S261320AbSKGPu0>;
	Thu, 7 Nov 2002 10:50:26 -0500
Date: Thu, 7 Nov 2002 10:57:06 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Why are exe, cwd, and root priviledged bits of information?
Message-ID: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the /prod/PID subset of procfs, why are the exe, cwd, and root symlinks
considered priviledged information?

Exe is the big one for me, as this one can be usually infered from reading
/prod/PID/maps.  Root I guess can't be inferred in any unpriviledged way,
and neither can cwd.  At any rate.. I am not sure behind the philosophy to
make these symlinks' destinations priviledged...  can someone clarify
this?

Thanks,

-Calin

