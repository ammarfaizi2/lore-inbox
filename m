Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWJCC0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWJCC0x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWJCC0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:26:53 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:2500 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1030248AbWJCC0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:26:52 -0400
Date: Tue, 3 Oct 2006 11:26:34 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add unifdef to gitignore
Message-ID: <20061003022634.GA6739@localhost.hsdv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been missed when unifdef went in
via Sam's tree..

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

--

diff --git a/scripts/.gitignore b/scripts/.gitignore
index a234e52..a1f52cb 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -5,3 +5,4 @@ conmakehash
 kallsyms
 pnmtologo
 bin2c
+unifdef
