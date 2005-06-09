Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVFIGSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVFIGSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVFIGSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:18:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11239 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262294AbVFIGSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:18:04 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: ipw2100: firmware problem
Date: Thu, 9 Jun 2005 09:17:23 +0300
User-Agent: KMail/1.5.4
Cc: jketreno@linux.intel.com, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
References: <42A7268D.9020402@linux.intel.com> <200506090903.49295.vda@ilport.com.ua> <20050608.231045.48808548.davem@davemloft.net>
In-Reply-To: <20050608.231045.48808548.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506090917.23853.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 June 2005 09:10, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Thu, 9 Jun 2005 09:03:49 +0300
> 
> > You practically cannot avoid having initrd because you are very likely
> > to need to do some wifi config (at least ESSID and mode).
> 
> I need neither at home.  It comes up by default just fine with
> ifconfig.
> 
> Your points are valid, but they do not detract from the fact that
> pieced up drivers, half in the kernel half somewhere else, is total
> madness.  It is a lose for the user.

Here I am totally agree. I would like to not have to mess with
separate firmware files. I even don't want binary firmware, gimme
the source!

Sadly, realities are such that we have to live somehow
with closed-source firmware. Worse, sometimes it even isn't freely
redistributable (vendor did not explicitly allowed that),
and thus we have to ship driver, but users must obtain
firmware elsewhere themself.

Thus so far we cannot avoid having split drivers.
--
vda

