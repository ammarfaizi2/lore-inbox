Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTFHW1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 18:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTFHW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 18:27:50 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:19938 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263983AbTFHW1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 18:27:50 -0400
Date: Sun, 8 Jun 2003 18:42:45 -0400
To: akpm@digeo.org
Cc: linux-kernel@vger.kernel.org
Subject: [BENCHMARK] 12% improvement in fork load from mm3 to mm4
Message-ID: <20030608224245.GA29947@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

autoconf build test creates about 1.2 million processes in
35 minutes.  On quad xeon, there was an improvement of 
~ 12% between 2.5.70-mm3 and 2.5.70-mm4.

              Avg of 3 runs
2.5.69-mm5    830.3 seconds
2.5.70        732.8
2.5.70-mjb1   719.5
2.5.70-mm3    829.0
2.5.70-mm4    737.9
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

