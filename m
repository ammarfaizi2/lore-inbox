Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTESQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTESQ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:59:49 -0400
Received: from terminus.zytor.com ([63.209.29.3]:12514 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262319AbTESQ7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:59:47 -0400
Message-ID: <3EC91086.7080908@zytor.com>
Date: Mon, 19 May 2003 10:12:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Steve Brueggeman <xioborg@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] submount: another removeable media handler
References: <200305160106.37274.eweiss@sbcglobal.net> <20030516113304.GK32559@Synopsys.COM> <200305161027.20045.eweiss@sbcglobal.net> <ba3bls$c2p$1@cesium.transmeta.com> <oc2icvot0lp3qaqpven4v7bgp6e7oc6krm@4ax.com>
In-Reply-To: <oc2icvot0lp3qaqpven4v7bgp6e7oc6krm@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Brueggeman wrote:
> Off Topic, sorry.
> 
> Is there a way to detect whether a floppy has been installed, without
> actually forcing the motor to spin, and heads to engage???
> 
> I'd like to create a simple auto-run utility that constantly looks for
> a special file on a MSDOS formatted floppy, and run it if found.
> Unfortunately, the only way I know of to determine if a floppy is
> installed is to open the floppy device, which causes the undesired
> motor spin-up, and head access.
> 
> Any help is greatly appreciated!!!
> 

Electrically it should be possible.  Whether or not the floppy device 
driver supports it is another matter.

	-hpa




