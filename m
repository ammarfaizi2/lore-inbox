Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUGKB3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUGKB3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUGKB3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:29:37 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:18846 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S266474AbUGKB3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:29:36 -0400
Date: Sat, 10 Jul 2004 18:29:35 -0700 (PDT)
From: vlobanov <vlobanov@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: Quick question.
Message-ID: <Pine.LNX.4.58.0407101826040.19771@shell1.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a quick question about a supposed scenario.

Suppose you have two pthreads - a main pthread and a utility pthread -
both running in the same application. The utility pthread is currently
in the middle of doing a recv() call on a network socket. At the same time,
the main pthread decides that it's time to exit, and either returns or
does a series of fork()/execv() calls. Is the behavior of the utility
pthread in such a case deterministic, and if so, what is it?

Thanks in advance for the help.

-Vadim Lobanov
