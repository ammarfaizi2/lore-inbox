Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTEaCJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 22:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTEaCJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 22:09:37 -0400
Received: from holomorphy.com ([66.224.33.161]:49554 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264103AbTEaCJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 22:09:36 -0400
Date: Fri, 30 May 2003 19:22:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Morten Helgesen <morten.helgesen@nextframe.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: list_head debugging patch
Message-ID: <20030531022239.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Morten Helgesen <morten.helgesen@nextframe.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1054292079.23566.22.camel@dhcp22.swansea.linux.org.uk> <Pine.SOL.4.30.0305301403090.1217-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305301403090.1217-100000@mion.elka.pw.edu.pl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2003, Alan Cox wrote:
>> The IDE code has real list mangling bugs at probe. They are fixed in -ac
>> but I'm still waiting for the taskfile stuff to get sorted so I can do
>> a sane merge of the stuff pending.

On Fri, May 30, 2003 at 02:17:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> List mangling at probe is fixed in 2.5.69-ac1, but there are more bugs
> with different triggerability.

Bartlomiej fixed up everything I could see during boot, things have
other, probably unrelated issues for me now (and mainline runs fine),
and he's finding something I can't see myself.


-- wli
