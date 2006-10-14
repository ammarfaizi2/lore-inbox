Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWJNALp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWJNALp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 20:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWJNALp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 20:11:45 -0400
Received: from gw.goop.org ([64.81.55.164]:62172 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932090AbWJNALo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 20:11:44 -0400
Message-ID: <45302C01.4070503@goop.org>
Date: Fri, 13 Oct 2006 17:14:57 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       John Richard Moser <nigelenki@comcast.net>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com>	 <452EA441.6070703@comcast.net> <452EA700.9060009@goop.org>	 <20061013233238.GA6038@rhlx01.fht-esslingen.de> <1160785812.25218.99.camel@localhost.localdomain>
In-Reply-To: <1160785812.25218.99.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> We already do. The newer x86 processors also have TLB tagging so they
> can (if you find one without errata!) avoid the actual flush and instead
> track the tag.

Are there any?  I think AMD dropped it rather than spend the effort to 
make it work.

    J

