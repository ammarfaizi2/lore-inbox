Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbVFVHqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVFVHqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVFVHpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:45:45 -0400
Received: from main.gmane.org ([80.91.229.2]:58496 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262832AbVFVFyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:54:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: -mm -> 2.6.13 merge status
Date: Wed, 22 Jun 2005 07:53:36 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.22.05.53.35.812738@smurf.noris.de>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <1119368364.3949.236.camel@betsy> <Pine.LNX.4.62.0506211222040.21678@graphe.net> <1119382685.3949.263.camel@betsy> <1119384131.15478.25.camel@localhost> <Pine.LNX.4.62.0506211306060.22372@graphe.net> <1119384473.3949.279.camel@betsy> <Pine.LNX.4.62.0506211309300.22490@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph Lameter wrote:

> Well we could use it in kernel to make select() work correctly.

select() already works correctly. It answers the "will I not block if I
call read()/write() on this" question, and since you never block on files
(assuming infinite disk speed ;-) select() will always return True on it.

You can't change this, it's in POSIX.

... or maybe I misunderstood your comment.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"I don't really miss God
 but i sure miss Santa Claus!"
      [Courtney Love]


