Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWDYNov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWDYNov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWDYNov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 09:44:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:51169 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932215AbWDYNou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 09:44:50 -0400
From: Andi Kleen <ak@suse.de>
To: jwcart2@epoch.ncsc.mil
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Tue, 25 Apr 2006 14:43:56 +0200
User-Agent: KMail/1.8
Cc: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <17485.55676.177514.848509@cse.unsw.edu.au> <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251443.57885.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 14:42, James Carter wrote:

> I talk to one of the unconfined people at the table and ask them to
> rename the "knife" to "spoon".  Now I am free to do what I wish.

That assumes that your jail allows talking to other people. 

> You don't care about the name "knife", you care about the object it
> represents.

In the apparmor model you only care about what the application is allowed
to do. If it does anything extraordinary like trying to talk to people it 
shouldn't talk to it gets a veto.

-Andi
