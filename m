Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUCHL66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 06:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUCHL66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 06:58:58 -0500
Received: from law10-f99.law10.hotmail.com ([64.4.15.99]:2314 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262003AbUCHL65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 06:58:57 -0500
X-Originating-IP: [141.156.159.253]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org, matthias.andree@gmx.de,
       lucasdss@yahoo.com.br, axboe@suse.de
Cc: cdrdao-info@lists.sourceforge.net, cdrdao-devel@lists.sourceforge.net
Subject: Re: Kernel 2.6.3 CD Burning Problems, Problem is NOT kernel related.
Date: Mon, 08 Mar 2004 11:58:56 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F99H3nq6dDKfJ0000b71a@hotmail.com>
X-OriginalArrivalTime: 08 Mar 2004 11:58:56.0458 (UTC) FILETIME=[BBF462A0:01C40504]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used cdrecord dev=ATAPI:0,0,0 and dev=ATAPI:1,0,0 and both burns ran 
simultaenously just fine (they are on separate IDE busses).

However, the problem here lies in cdrdao, it does not see 1,0,0.

Instead, it -thinks- that IDE1 => IDE0, and IDE1 does not exist.

CDRDAO see's hdc (burner 2), hdd (dvd drive), but not hda (burner1).

Any other suggestions as to why cdrdao does not see the other burner (hda)?  
As cdrecord see's both burners and burns on both simtulaenously without any 
errors, I assume the problem lies in cdrdao.

_________________________________________________________________
Store more e-mails with MSN Hotmail Extra Storage – 4 plans to choose from! 
http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/

