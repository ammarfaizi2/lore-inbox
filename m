Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUCKWuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUCKWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:50:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:34006 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261804AbUCKWt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:49:58 -0500
Subject: Re: [PATCH] therm_adt7467 update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <00e401c40776$2a37eca0$3cc8a8c0@epro.dom>
References: <00e401c40776$2a37eca0$3cc8a8c0@epro.dom>
Content-Type: text/plain
Message-Id: <1079045140.9745.295.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Mar 2004 09:45:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 01:35, Colin Leroy wrote:
> Hi,
> 
> the fan driver I wrote for adt746x looks like it only handles the adt7467
> chip found in iBooks G4; but it also handles the adt7460 chip found in the
> Powerbook G4 Alu.
> Here's a patch that renames the file to therm_adt746x.c and updates
> Kconfig and Makefile. I also changed a few lines in therm_adt746x.c after
> renaming it (the patch contains these), the diff is here for clarity:

Ok, I'll look into getting that upstream. Renaming things is a bit
nasty (makes big patch for little changes) unless Linus does
directly a "bk mv" in his tree..

Ben.


