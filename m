Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318890AbSH1PmQ>; Wed, 28 Aug 2002 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSH1PlO>; Wed, 28 Aug 2002 11:41:14 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:3715 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318882AbSH1PlH>; Wed, 28 Aug 2002 11:41:07 -0400
Date: Wed, 28 Aug 2002 16:45:17 +0100
Message-Id: <200208281545.g7SFjH814318@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 0/8] 2.4.20-pre4/ext3: ext3 misc updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This next batch of patches contains a number of minor updates to ext3
on 2.4, including some performance and correctness fixes for fsync and
O_SYNC in non-default journaling modes, and one important fix to avoid
marking the fs as containing an error if we run out of inodes.

--Stephen
