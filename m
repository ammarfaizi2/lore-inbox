Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTHLLC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270066AbTHLLC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:02:26 -0400
Received: from post.tau.ac.il ([132.66.16.11]:35750 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S269981AbTHLLCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:02:23 -0400
Subject: Re: suspend fails under load
From: Micha Feigin <michf@post.tau.ac.il>
To: Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030808135037.GE6914@openzaurus.ucw.cz>
References: <1060178056.1390.4.camel@litshi.luna.local>
	 <20030808135037.GE6914@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1060686223.3777.1.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Aug 2003 14:03:43 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.0; VDF: 6.21.0.11; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-08 at 16:50, Pavel Machek wrote:
> Hi!
> 
> > Under kernel 2.6.0-test2 I get the behaviour that when trying to suspend
> > under load, I get all the way to the black screen, after which I am
> > supposed to see the writing pages to disk message.
> > Instead I see an error message flashing by to fast to read and
> 
> that's easy: add mdelays to suspend.c :-)

Would like to, but couldn't tell where the message was coming from so
that I can put it in the right location ;)
If I could read the message then I would be able to know what to grep
for, kind of the chicken and the egg.
-- 
Micha Feigin
michf@math.tau.ac.il

