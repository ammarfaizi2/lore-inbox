Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278976AbRJ2EIt>; Sun, 28 Oct 2001 23:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278977AbRJ2EIj>; Sun, 28 Oct 2001 23:08:39 -0500
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:57348 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S278976AbRJ2EI1>;
	Sun, 28 Oct 2001 23:08:27 -0500
Date: Sun, 28 Oct 2001 22:08:54 -0600
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: /proc/net/ip_conntrack problems
Message-ID: <20011028220854.A17685@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

% dd if=/proc/net/ip_conntrack bs=128 | wc -l
0+0 records in
0+0 records out
      0
% dd if=/proc/net/ip_conntrack bs=256 | wc -l
0+3 records in
0+3 records out
      3
% dd if=/proc/net/ip_conntrack bs=512 | wc -l
0+2 records in
0+2 records out
      5

Can anyone explain this? (2.4.13-ac3) It's wreaking havoc with my
program.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
