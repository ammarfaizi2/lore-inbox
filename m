Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTGKRNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTGKRNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:13:08 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:35542
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263315AbTGKRNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:13:05 -0400
Date: Fri, 11 Jul 2003 13:27:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Henrique Oliveira <henrique2.gobbi@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Message-ID: <20030711172747.GK2210@gtf.org>
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk> <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva> <003101c34712$a9b8f480$602fa8c0@henrique> <1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk> <013901c347cd$44586f60$602fa8c0@henrique> <Pine.LNX.4.55L.0307111416100.29959@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307111416100.29959@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 02:18:10PM -0300, Marcelo Tosatti wrote:
> I am.
> 
> Please report the results of your tests and CC lkml.
> 
> And Alan, what the -ac tree hdlc changes are about ?

IMO hdlc is a "raidtools-like situation":

New HDLC stuff (already in 2.5) was also developed for 2.4.  It changes
the 2.4 HDLC userland ABI... but pretty much everybody who still
cares about HDLC is using the new (changed) ABI.

	Jeff



