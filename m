Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280952AbRKLTkO>; Mon, 12 Nov 2001 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280949AbRKLTkE>; Mon, 12 Nov 2001 14:40:04 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:56334 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S280944AbRKLTjv>;
	Mon, 12 Nov 2001 14:39:51 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111121939.UAA04358@nbd.it.uc3m.es>
Subject: what is teh current meaning of blk_size?
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Mon, 12 Nov 2001 20:39:44 +0100 (CET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is blk_size[][] supposed to contain the size in KB or blocks?

I'm confused because it looks to me as though it's still in KB,
but people say that devices can be up to 8 or 16TB, and there's
not enough room for that within a signed int containing KB
(2^31 * 2^10 = 2^41 = 2TB).

Either the rumour is true and it's in blocks, or the rumour
is false and it's in KB.

Clue, please!

Peter
