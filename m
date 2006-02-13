Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWBMKzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWBMKzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBMKzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:55:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13790 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932277AbWBMKzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:55:19 -0500
Date: Mon, 13 Feb 2006 11:55:18 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: cfriesen@nortel.com, tytso@mit.edu, peter.read@gmail.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.105324.23178.atrey@ucw.cz>
References: <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <43ECA70C.8050906@nortel.com> <43ECA8BC.nailJHD157VRM@burner> <43ECADA8.9030609@nortel.com> <43F05FB2.nailKUS3MR1N9@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F05FB2.nailKUS3MR1N9@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Just think about a program that checks a file that is on a removable media.
> 
> This media is mounted via a vold service and someone removes the USB cable
> and reinserts it a second later. The filesystem on the device will be mounted
> on the same mount point but the device ID inside the system did change.
> 
> As a result, the file unique identification st_ino/st_dev is not retained 
> and the program is confused.

And it would be equally confused if I inserted a different media instead.

Relying on stability of anything across mounts/umounts does not make any
sense.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The number of UNIX installations has grown to 10, with more expected.  (6/72)
