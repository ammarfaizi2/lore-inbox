Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbRGXQFk>; Tue, 24 Jul 2001 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267776AbRGXQFa>; Tue, 24 Jul 2001 12:05:30 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:64673 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267619AbRGXQFW>; Tue, 24 Jul 2001 12:05:22 -0400
Date: Tue, 24 Jul 2001 18:05:26 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, net-tools@lina.inka.de, philb@gnu.org
Subject: Re: ifconfig and SIOCSIFADDR
Message-ID: <20010724180526.G750@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200107241447.OAA07015@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200107241447.OAA07015@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jul 24, 2001 at 02:47:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Andries,

On Tue, Jul 24, 2001 at 02:47:56PM +0000, Andries.Brouwer@cwi.nl wrote:
> I just noticed that the command
> 
> 	ifconfig eth1 netmask 255.255.255.0 broadcast 10.0.0.255 10.0.0.150
> 
> (with ifconfig from net-tools-1.60)
> results in a netmask of 255.0.0.0, which is wrong in my situation.
 
Just change this to 

   ifconfig eth1 10.0.0.150  netmask 255.255.255.0 broadcast 10.0.0.255

and be happy.

Deciding about bugs vs. "undefined behavior" is not my business,
so I bite my tongue about this topic ;-)

Regards

Ingo Oeser
-- 
Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
