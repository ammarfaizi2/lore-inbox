Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTFPVNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFPVNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:13:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:26378 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264262AbTFPVNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:13:43 -0400
Date: Mon, 16 Jun 2003 22:27:35 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Gerhard Mack <gmack@innerfire.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <Pine.LNX.4.44.0306142058580.4513-100000@innerfire.net>
Message-ID: <Pine.LNX.4.44.0306162226250.26878-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm seeing corruption on the screen if I use anything that scrols like
> pine or menuconfig.
> 
> It goes away if I disable preempt.

Preempt and the VT console system are not friends. There are way to many 
global variables which have there states altered in many spots.


