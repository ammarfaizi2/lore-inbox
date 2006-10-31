Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423290AbWJaNvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423290AbWJaNvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423295AbWJaNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:51:36 -0500
Received: from smtp5.orange.fr ([193.252.22.26]:3107 "EHLO
	smtp-msa-out05.orange.fr") by vger.kernel.org with ESMTP
	id S1423290AbWJaNvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:51:35 -0500
X-ME-UUID: 20061031135134230.383041C001E2@mwinf0502.orange.fr
Subject: Re: [PATCH v2] Re: Battery class driver.
From: Xavier Bestel <xavier.bestel@free.fr>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, davidz@redhat.com,
       Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
	 <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 14:51:26 +0100
Message-Id: <1162302686.31012.47.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 15:42 +0200, Shem Multinymous wrote:
> > >Jean, what's your opinion on letting hwmon-ish attributes specify
> > >units as "%d %s" where these are hardware-dependent?
> >
> > I fail to see any benefit in doing so, while I see several problems (see
> > above) and potential for confusion. So my opinion is: please don't do
> > that.
> 
> Well, we have to do *something* about those devices that don't have
> fixed units (see my mail to Greg from a few minutes ago), so which
> alternative do you prefer?

How about converting on the fly ?

	Xav

