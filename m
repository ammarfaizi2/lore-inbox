Return-Path: <linux-kernel-owner+w=401wt.eu-S965143AbWLTQEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWLTQEI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWLTQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:04:08 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3990 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965143AbWLTQEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:04:07 -0500
Date: Wed, 20 Dec 2006 16:04:00 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
In-Reply-To: <20061220125314.GA24188@srcf.ucam.org>
Message-ID: <Pine.LNX.4.64N.0612201558250.11005@blysk.ds.pg.gda.pl>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net>
 <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net>
 <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org>
 <1166601025.3365.1345.camel@laptopd505.fenrus.org> <20061220125314.GA24188@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Matthew Garrett wrote:

> As far as I can tell, the following network devices don't put the 
> hardware into D3 on interface down:
[...]
> defxx

 No support in the hardware for that.  Even revision 3 of the board which 
is the last one and the only to support PCI 2.2 says:

Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

;-)

  Maciej
