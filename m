Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTFDW2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTFDW2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:28:09 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12166
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264248AbTFDW0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:26:35 -0400
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysiek Taraszka <dzimi@pld.org.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200306042341.27160.dzimi@pld.org.pl>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200305292218.38127.dzimi@pld.org.pl>
	 <Pine.LNX.4.55L.0306041515050.11972@freak.distro.conectiva>
	 <200306042341.27160.dzimi@pld.org.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054766238.14284.79.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 23:37:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 22:41, Krzysiek Taraszka wrote: 
> -rc3 in subject :)) with another fixes but without cmd640 fixes.
> Alan made almoust the same changes but him ac tree still have got broken 
> cmd640 modular driver (cmd640_vlb still is unresolved).
> I tried hack it .. but I droped it ... maybe tomorrow i back to that code ... 
> or someone goes to fix it (maybe Alan ?)

cmd640_vlb is gone from the core code in the -ac tree so that suprises
me. Adrian Bunk sent me some more patches to look at. I'm not 100% 
convinced by them but there are a few cases left and some of his stuff
certainly fixes real problems

