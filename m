Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265793AbUFORmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265793AbUFORmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFORmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:42:40 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:43334 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265793AbUFORmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:42:06 -0400
Date: Tue, 15 Jun 2004 12:42:35 -0500
To: linux-kernel@vger.kernel.org
Cc: dcn@sgi.com, rusty@rustcorp.com.au
Subject: calling kthread_create() from interrupt thread
Message-ID: <40CF350B.mailxD2X1NPFBC@aqua.americas.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: dcn@sgi.com (Dean Nelson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a driver that needs to create threads that can sleep/block
for an indefinite period of time.

    . Can kthread_create() be called from an interrupt handler?

    . Is the cost of a kthread's creation/demise low enough so that one
      can, as often as needed, create a kthread that performs a simple
      function and exits?  Or is the cost too high for this?

Thanks,
Dean
