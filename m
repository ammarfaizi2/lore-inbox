Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWDXQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWDXQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWDXQyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 12:54:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750711AbWDXQyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 12:54:07 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] 
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: David Lang <dlang@digitalinsight.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0604240730030.30494@qynat.qvtvafvgr.pbz>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424125641.GD9311@sergelap.austin.ibm.com>
	 <1145887333.29648.44.camel@localhost.localdomain>
	 <20060424140407.GD22703@sergelap.austin.ibm.com>
	 <Pine.LNX.4.62.0604240730030.30494@qynat.qvtvafvgr.pbz>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 18:50:53 +0200
Message-Id: <1145897454.3116.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> the 'hard shell, soft center' approach isn't as secure as 'full 
> hardening' (assuming that both are properly implemented), but the fact 
> that it's far easier to understand and configure the hard shell means that 
> it's also far more likly to be implemented properly.

I can certainly see value in a "take away degrees of freedom" approach.
In fact many security approaches are just that, and that's just fine
with me, and clearly of value.

There is a distinction between really taking away a degree of freedom
and just appearing to do so + easy workaround. Which is why we're having
this discussion, to make sure AppArmor is of the former type ;)


