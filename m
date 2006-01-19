Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWASXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWASXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWASXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:45:09 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:60033 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1422689AbWASXpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:45:06 -0500
Date: Fri, 20 Jan 2006 00:45:05 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: 3c59x went nuts between .15-mm3 and .15-mm4
Message-ID: <20060119234505.GO16047@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
	jamagallon@able.es, linux-kernel@vger.kernel.org
References: <20060119225345.18a570ae@werewolf.auna.net> <20060119223114.GN16047@bayes.mathematik.tu-chemnitz.de> <20060119152757.6d7f3924.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119152757.6d7f3924.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 706061e527a23eaab6b0df22823cde1c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 03:27:57PM -0800, Andrew Morton wrote:
> Steffen Klassert <klassert@mathematik.tu-chemnitz.de> wrote:
> >
> > The driver version did not increase since more than three years.
> > But perhaps it is a good idea to maintain the driver version. 
> 
> Just nuke it.  Per-driver versioning is pretty meaningless and we should
> and do identify driver versions by the version of the top-level kernel
> which contains them.

Well, I will remove it with the next patch series.

Steffen

