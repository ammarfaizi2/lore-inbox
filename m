Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132816AbRDDQOD>; Wed, 4 Apr 2001 12:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132810AbRDDQNq>; Wed, 4 Apr 2001 12:13:46 -0400
Received: from dentin.eaze.net ([216.228.128.151]:24078 "EHLO xirr.com")
	by vger.kernel.org with ESMTP id <S132784AbRDDQNY>;
	Wed, 4 Apr 2001 12:13:24 -0400
Date: Wed, 4 Apr 2001 11:12:15 -0500 (CDT)
From: SodaPop <soda@xirr.com>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTION] 2.4.x nice level
Message-ID: <Pine.LNX.4.30.0104041104510.9687-100000@xirr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too have noticed that nicing processes does not work nearly as
effectively as I'd like it to.  I run on an underpowered machine,
and have had to stop running things such as seti because it steals too
much cpu time, even when maximally niced.

As an example, I can run mpg123 and a kernel build concurrently without
trouble; but if I add a single maximally niced seti process, mpg123 runs
out of gas and will start to skip while decoding.

Is there any way we can make nice levels stronger than they currently are
in 2.4?  Or is this perhaps a timeslice problem, where once seti gets cpu
time it runs longer than it should since it makes relatively few system
calls?

-dennis T

