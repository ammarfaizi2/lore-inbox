Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263951AbTDNVng (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263950AbTDNVnF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:43:05 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:62080
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263949AbTDNVlR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:41:17 -0400
To: linux-kernel@vger.kernel.org
Subject: 3c59x module from 2.5.67 broken on Alpha
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 14 Apr 2003 23:52:50 +0200
Message-ID: <yw1xel44691p.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 3c59x module in linux 2.5.67 fails to load on Alpha.  I get this
in my log:

module 3c59x: Relocation overflow vs section 17

The kernel is built with gcc 3.2.2 and binutils 2.13.

-- 
Måns Rullgård
mru@users.sf.net
