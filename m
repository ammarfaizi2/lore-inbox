Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULZOUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULZOUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbULZOUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:20:39 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:60556 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261578AbULZOUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:20:34 -0500
Date: Sun, 26 Dec 2004 15:20:33 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 des ECB encryption test5 setkey() failed
Message-ID: <20041226142033.GA7508@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not using crypto but it gets compiled in anyway. I noticed this in dmesg:

testing des ECB encryption
test 1 (64 bit key):
c95744256a5ed31d
pass
test 2 (64 bit key):
f79c892a338f4a8b
pass
test 3 (64 bit key):
690f5b0d9a26939b
pass
test 4 (64 bit key):
c95744256a5ed31df79c892a338f4a8bb49926f71fe1d490
pass
test 5 (64 bit key):
setkey() failed flags=100100
c95744256a5ed31d
pass


system: dual PIII, gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)


-- 
Frank
