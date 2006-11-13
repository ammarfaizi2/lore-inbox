Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWKMRqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWKMRqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWKMRqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:46:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35816 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932144AbWKMRqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:46:30 -0500
X-Sasl-enc: nHkYkYPhJwWMZ7C8WeKWggnajMBOGMjoEemYXEEhVS6b 1163439991
Date: Mon, 13 Nov 2006 15:46:21 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Michael Holzheu <HOLZHEU@de.ibm.com>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061113174621.GA17406@khazad-dum.debian.net>
References: <20061108090454.dba20e01.randy.dunlap@oracle.com> <OF2A3BB933.427A044B-ON41257220.006509CA-41257220.00656F8A@de.ibm.com> <20061110065336.GA13646@kroah.com> <20061113121802.GC31613@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113121802.GC31613@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Pavel Machek wrote:
> We could do something like 
> 
> battery_stored_energy and battery_stored_current
>                  (mWh)                      (mAh)

"Energy" and "charge", please.  You cannot store "current", it is an unit
used to measure flows.  Anyway, we are just repeating arguments that were
made already in the battery thread...

And, please let's follow the SBS spec naming if possible for the attributes.
They put a lot of thought on the way they named things.  Again, this is
already in the battery thread...

> ...but it looks ugly, and battery_capacity:mAh does not sound that bad
> for a new interface.

Indeed, battery_capacity:mWh and battery_capacity:mAh would work just fine
and it does look better.  But unless Greg changes his mind, it looks like we
shall do without units in the filenames, which will also work just fine, if
small enough units are choosen...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
