Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTETVoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTETVoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 17:44:07 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:8631 "HELO
	fargo") by vger.kernel.org with SMTP id S261265AbTETVoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 17:44:06 -0400
Date: Wed, 21 May 2003 00:02:02 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e100 driver
Message-ID: <20030520220202.GA15628@fargo>
Mail-Followup-To: "Feldman, Scott" <scott.feldman@intel.com>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D71E@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D71E@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

> > <31>May 19 09:05:42 kernel: hw tcp v4 csum failed
> > <31>May 19 09:11:11 kernel: icmp v4 hw csum failure
> 
> David/Hugo, can you try turning off Rx checksum offloading in e100?  Set the
> module parameter XsumRX=0 to turn it off.  

I reloaded again the e100 module with this parameter. Let's see how it performs.
Thanks for the advice ;)

I'll let you know if checksum errors doesn't show anymore.


-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
