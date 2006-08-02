Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWHBSNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHBSNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWHBSNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:13:31 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:48257 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S932119AbWHBSNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:13:31 -0400
Message-ID: <44D0EB07.4040007@mauve.plus.com>
Date: Wed, 02 Aug 2006 19:12:23 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       David Lang <dlang@digitalinsight.com>,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       lkml@lpbproductions.com, Jeff Garzik <jeff@garzik.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       LKML Kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>	<200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>	<20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>	<44CE7C31.5090402@gmx.de>	<5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>	<Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>	<5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>	<Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>	<5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>	<20060801010215.GA24946@merlin.emma.line.org>	<44CEAEF4.9070100@slaphack.com>	<Pine.LNX.4.63.0607312114500.15179@qynat.qvtvafvgr.pbz>	<44CED95C.10709@slaphack.com> <44CFE8D9.9090606@mauve.plus.com>	<0DA0B214-50BC-4E20-A520-B7AB121BB38B@mac.com> <m3ejvzqkjf.fsf@defiant.localdomain>
In-Reply-To: <m3ejvzqkjf.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
> 
> 
>>IMHO the best alternative for a situation like that is a storage
>>controller with a battery-backed cache and a hunk of flash NVRAM for
>>when the power shuts off (just in case you run out of battery), as
>>well as a separate 1GB battery-backed PCI ramdisk for an external
>>journal device (likewise equipped with flash NVRAM).  It doesn't take


> Not sure - reading flash is fast, but writing is quite slow.
> A digital camera can consume a set of 2 or 4 2500 mAh AA cells
> for a fraction of 1 GB (of course, only a part of power goes
> to flash).

Yeah - that's why I said in the original message that it's not
especially lower in energy - the energy is used at a lower rate,
so is much cheaper to supply.
http://www.samsung.com/products/semiconductor/NORFlash/256Mbit/K8A5615EBA/K8A5615EBA.htm 
's datasheet says to program the 32Mbyte chip takes about 30mw*120s, or 
3.5J or so.
For a gigabyte, that's 100J - a fairly substantial amount of energy.
However - it's at a low rate, so it's not _too_ expensive to supply.
