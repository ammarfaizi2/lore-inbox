Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCAPCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUCAPCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:02:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40580 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261326AbUCAPCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:02:32 -0500
Date: Mon, 1 Mar 2004 10:04:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: -Wshadow
Message-ID: <Pine.LNX.4.53.0403010958240.31041@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't know about the latest version(s), but with 2.4.25, compiling
with -Wshadow brings up a lot of potential problems. One can
turn off (temporarily) the built in functions to get rid of the
spurious warnings about memcpy(), etc., then you see that too many
variables to mention here are shadowed (probably thousands). Some
of them may be hazardous because they are spin-lock variables and
semaphores. There are also some shadowed functions. NotGood(tm)!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


