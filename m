Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTKVSb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKVSb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:31:29 -0500
Received: from ajlill.sentex.ca ([64.7.134.25]:1953 "EHLO
	spider.ajlc.waterloo.on.ca") by vger.kernel.org with ESMTP
	id S262610AbTKVSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:30:08 -0500
Message-Id: <200311221830.hAMIU7aE029166@spider.ajlc.waterloo.on.ca>
To: linux-kernel@vger.kernel.org
Subject: smbfs freezes on 2.6.0-test9-mm1
From: Tony Lill <ajlill@ajlc.waterloo.on.ca>
Content-Type: text/plain; charset=US-ASCII
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Date: Sat, 22 Nov 2003 13:30:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading to 2.6 from 2.4, smbfs has been hanging. This isn't
the usual error you get when the connection times out. For one, I
changed the timeout on the server to ffff minutes, for another it did
recover from those.

Has anyone seen (and fixed) this before.

I'd go back to 2.4 except 2.6 did something to my filesystem to make
them incompatable with 2.4.

TIA
--
Tony Lill,                         Tony.Lill@AJLC.Waterloo.ON.CA
President, A. J. Lill Consultants        fax/data (519) 650 3571
539 Grand Valley Dr., Cambridge, Ont. N3H 2S2     (519) 241 2461
--------------- http://www.ajlc.waterloo.on.ca/ ----------------
"Welcome to All Things UNIX, where if it's not UNIX, it's CRAP!"
