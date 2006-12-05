Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967459AbWLESz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967459AbWLESz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968629AbWLESz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:55:56 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:48531 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967459AbWLESzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:55:55 -0500
Date: Tue, 5 Dec 2006 19:53:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Willy Tarreau <w@1wt.eu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: makei: shell script for building .i files
In-Reply-To: <200612040423_MC3-1-D3DD-B749@compuserve.com>
Message-ID: <Pine.LNX.4.61.0612051952470.18570@yvahk01.tjqt.qr>
References: <200612040423_MC3-1-D3DD-B749@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>#!/bin/bash
>#
>#	scripts/makei
>#
># Make .i files in Linux kernel tree.  You must first build a
># working kernel so this script knows which files to make.

Would -fsave-temps of gcc do the same? (Half the answer: no, it saves 
the temp files in $KSRC rather than $O)


	-`J'
-- 
