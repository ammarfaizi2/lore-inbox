Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUBYSqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUBYSqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:46:31 -0500
Received: from mail.artsci.net ([64.29.142.100]:33031 "EHLO jadsystems.com")
	by vger.kernel.org with ESMTP id S262274AbUBYSqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:46:09 -0500
Date: Wed, 25 Feb 2004 10:44:56 -0800
Message-Id: <200402251044.AA2351169658@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jim Deas" <jdeas0648@jadsystems.com>
Reply-To: <jdeas0648@jadsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: scheduling while atomic error in driver
X-Mailer: <IMail v6.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am still trying to get the terms down.
Could this message be caused by an interrupt driven routine calling schedule() ?
Is schedule the command used to allow another task to interrupt the current routine?
I am moving 2.4 code with task queues to 2.6 with workqueues. I
see this error but want to make sure I understand why it exist
before starting to code around.

JD


