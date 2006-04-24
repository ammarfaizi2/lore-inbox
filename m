Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWDXINn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWDXINn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWDXINn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:13:43 -0400
Received: from gate.in-addr.de ([212.8.193.158]:30638 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751141AbWDXINm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:13:42 -0400
Date: Mon, 24 Apr 2006 10:14:34 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Stephen Smalley <sds@tycho.nsa.gov>, Nix <nix@esperi.org.uk>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060424081433.GG440@marowsky-bree.de>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu> <32851499-DA27-46AF-A1A4-E668BBE0771D@mac.com> <1145536803.3313.32.camel@moss-spartans.epoch.ncsc.mil> <87y7xzu4hj.fsf@hades.wkstn.nix> <1145629477.21749.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145629477.21749.146.camel@moss-spartans.epoch.ncsc.mil>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-21T10:24:37, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > (With AppArmor, of course, you never lose labels at all, because there
> > aren't any.)
> But you do lose preservation of security properties, e.g. renaming a
> file suddenly moves it under different protection.  Same end result.

This is not correct, as far as I understand. As the app can only rename
in it has access to both the old and the new path.


-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

