Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271114AbTGWGl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTGWGl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:41:29 -0400
Received: from pro5.mtco.com ([207.179.200.251]:23461 "HELO pro5.mtco.com")
	by vger.kernel.org with SMTP id S271114AbTGWGl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:41:29 -0400
From: Tom Felker <tcfelker@mtco.com>
To: linux-kernel@vger.kernel.org
Subject: root= needs hex in 2.6.0-test1-mm2
Date: Wed, 23 Jul 2003 01:56:40 -0500
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307230156.40762.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I finally booted 2.6.0-test1-mm2, after reading somebody else who needed to 
use hex in the root= argument.  root=/dev/hdb1 and root=hdb2 would panic 
("VFS: Cannot open root device hdb1 or unknown-block(0,0)"), but root=0341 
worked.  Devfs is compiled in, devfs=nomount and devfs=mount make no 
difference.  Is this intentional?

-- 
Tom Felker

Try not!  Do! or do not.  There is no try.
 -- Yoda

