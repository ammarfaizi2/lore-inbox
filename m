Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUBIHR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 02:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBIHR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 02:17:56 -0500
Received: from hera.kernel.org ([63.209.29.2]:29162 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264927AbUBIHRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 02:17:55 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Does anyone still care about BSD ptys?
Date: Mon, 9 Feb 2004 07:17:27 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c07c67$vrs$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076311047 32637 63.209.29.3 (9 Feb 2004 07:17:27 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 9 Feb 2004 07:17:27 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
thinking of restructuring the pty system slightly to make it more
dynamic and to make use of the new larger dev_t, and I'd like to get
rid of the BSD ptys as part of the same patch.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
