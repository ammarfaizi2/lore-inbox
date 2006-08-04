Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161405AbWHDUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161405AbWHDUwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWHDUwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:52:03 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:60107 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161405AbWHDUwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:52:01 -0400
Message-ID: <44D3B36F.7010501@slaphack.com>
Date: Fri, 04 Aug 2006 16:51:59 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Russell Leighton <russ@elegant-software.com>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Checksumming blocks? [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com> <20060803135811.GA7431@merlin.emma.line.org> <44D285DF.7060905@elegant-software.com>
In-Reply-To: <44D285DF.7060905@elegant-software.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Leighton wrote:

> Is there a recovery mechanism, or do you just be happy you know there is 
> a problem (and go to backup)?

You probably go to backup anyway.  The recovery mechanism just means you 
get to choose the downtime to restore from backup (if there is 
downtime), versus being suddenly down until you can restore.
