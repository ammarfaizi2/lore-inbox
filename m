Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUD0OFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUD0OFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUD0OFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:05:42 -0400
Received: from stingr.net ([212.193.32.15]:27592 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S264102AbUD0OFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:05:36 -0400
Date: Tue, 27 Apr 2004 18:05:34 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427140533.GI14129@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org> <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net> <20040426225620.GP17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net> <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Grzegorz Kulewski:
> But it is strange that I need kernel patch even if I have no evms 
> or dm volumes in my system. Can not it be solved in mainstream kernels?
> Maybe there should be warning in config help temporaily? Maybe even note 
> after option name?

This defect grew up off a disagreement between bdclaim authors and
evms authors, but as gentoo is topmost in this pyramid I consider it's
guilty :)

just exclude yours partitioned drivers out of evms scan
(/etc/evms.conf)
-or-
mount it thru evms nodes (/dev/evms/*)

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
