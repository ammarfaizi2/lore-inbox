Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVKOS0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVKOS0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVKOS0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:26:08 -0500
Received: from science.horizon.com ([192.35.100.1]:22859 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964991AbVKOS0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:26:07 -0500
Date: 15 Nov 2005 13:25:56 -0500
Message-ID: <20051115182556.23441.qmail@science.horizon.com>
From: linux@horizon.com
To: cloud.of.andor@gmail.com
Subject: Re: [PATCH] getrusage sucks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might mention that ESRCH is the usual "that process does not exist"
error return, not EINVAL.  (See kill(2), ptrace(2), setpgrp(2), etc.)
