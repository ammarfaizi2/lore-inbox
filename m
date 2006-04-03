Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWDCQMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWDCQMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWDCQMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:12:32 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:2993 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751761AbWDCQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:12:30 -0400
Date: Mon, 3 Apr 2006 18:12:29 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: LKML <linux-kernel@vger.kernel.org>
Subject: False OOM with swappiness == 0
Message-ID: <Pine.LNX.4.64.0604031811270.7588@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On one our server we've seen that OOM killer kills a process even if 
there's plenty of free swap space. The server had swappiness set to 0 
which probably triggered the bug.

Mikulas
