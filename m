Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSCCSg3>; Sun, 3 Mar 2002 13:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSCCSgS>; Sun, 3 Mar 2002 13:36:18 -0500
Received: from juguete.quim.ucm.es ([147.96.5.11]:50191 "EHLO
	juguete.quim.ucm.es") by vger.kernel.org with ESMTP
	id <S288012AbSCCSgO>; Sun, 3 Mar 2002 13:36:14 -0500
Date: Sun, 3 Mar 2002 19:36:12 +0100 (CET)
From: Ramon Garcia Fernandez <ramon@juguete.quim.ucm.es>
To: linux-kernel@vger.kernel.org
Subject: I/O scheduling suggestion
Message-ID: <Pine.LNX.4.21.0203031920280.21108-100000@juguete.quim.ucm.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, my congratulations for the implementation of i/o scheduling.
It was long overdue.

One suggestion: why not use the process* for scheduling, so that processes
that do a lot of i/o are penalized? A field in the process struct could
contain i/o priority for this purpose. Shouldn't i/o be scheduled exactly in
the same way as the CPU, since it is a shared resource?

Ramon

