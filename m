Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTLDUcG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLDUcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:32:06 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13032
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263496AbTLDUcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:32:04 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 4 Dec 2003 14:32:23 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041432.23907.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can make a file with a hole by seeking past it and never writing to that 
bit, but is there any way to punch a hole in a file after the fact?  (I mean 
other with lseek and write.  Having a sparse file as the result....)

What are the downsides of holes?  (How big do they have to be to actually save 
space, is there a performance penalty to having a file with 1000 4k holes in 
it, etc...)

Rob
