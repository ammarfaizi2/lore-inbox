Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTGWRLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270471AbTGWRLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:11:14 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:5291 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S270469AbTGWRLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:11:10 -0400
Date: Wed, 23 Jul 2003 19:25:58 +0200
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 gets corrupted data when loading init
Message-ID: <20030723172557.GA3217@h55p111.delphi.afb.lu.se>
References: <20030718083458.GC5964@h55p111.delphi.afb.lu.se> <20030718095108.GE5964@h55p111.delphi.afb.lu.se> <20030718113950.GF5964@h55p111.delphi.afb.lu.se> <640742704.1058910391@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640742704.1058910391@aslan.btc.adaptec.com>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19fNNG-00014z-00*DCaXFEKnt96*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 03:46:31PM -0600, Justin T. Gibbs wrote:
> There are a whole slew of later changesets that haven't made it in yet.
> The root cause of your particular problem is not the lun copy optimization,
> but a problem with the layout of a data structure that is dma'ed to the
> controller and a controller errata.  The fix for this is available in 
> the 20030603 bksend file at my site:
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/

Yes, thanks, that works just fine.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
