Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUJLTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUJLTRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJLTPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:15:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4841 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267713AbUJLTNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:13:22 -0400
Date: Tue, 12 Oct 2004 21:14:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Mathieu Segaud <matt@minas-morgul.org>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1 Oops [2]
Message-ID: <20041012191435.GA3310@elte.hu>
References: <416B9517.7010708@blueyonder.co.uk> <877jpwi8cg.fsf@barad-dur.crans.org> <200410121607.i9CG7PsQ001076@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410121607.i9CG7PsQ001076@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> I started seeing the same problem on -rc4-mm1, and couldn't figure out
> why I didn't see it on -rc3-mm3.  Finally figured out that it was
> because the -rc3-mm3 had a -VP patch on it, and the -rc4-mm1 didn't
> (because of the UP build problems in -T5).  Ingo's patch also reverts
> that patch, so I got the fix 'free of charge'....
> 
> Ingo: Was that intentional, or it just happened?

was intentional - such small fixes are typical in the -VP patches since
i first have to merge it and get it work on my testboxes, so if any
last-minute bug slips into -mm i add the fix to VP.

	Ingo
