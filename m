Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUA0RKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUA0RKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:10:10 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.117]:57769 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S262848AbUA0RKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:10:05 -0500
Message-ID: <40169B58.4070103@myrealbox.com>
Date: Tue, 27 Jan 2004 09:09:44 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5a (Windows/20040113)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Special promisc receive mode
References: <fa.ijk3qim.15ls9ju@ifi.uio.no>
In-Reply-To: <fa.ijk3qim.15ls9ju@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try ebtables (http://ebtables.sourceforge.net/).  You'll need to add 
eth0 to a bridge first, though.

--Andy

Karel Kulhavý wrote:

> Hello
> 
> I need to tell kernel that e. g. eth0 is a point-to-point link and that every
> ethernet frame should be treated this way:
> 1) Replace destination MAC with MAC of the eth0 network card
> 2) Process as normally
> 
> I tried to set up promisc mode but it seems to not work - it looks like the
> frames are intercepted, however are not treated as destinated for my host (are
> not forwared etc.)
> 
> Cl<
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
