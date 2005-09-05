Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVIEQ1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIEQ1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVIEQ1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:27:04 -0400
Received: from orb.pobox.com ([207.8.226.5]:57571 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932226AbVIEQ1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:27:02 -0400
Message-ID: <431C71D4.8070402@rtr.ca>
Date: Mon, 05 Sep 2005 12:27:00 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Oliver Tennert <O.Tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD+-R[W] regression in 2.6.12/13
References: <200509051533.01465.tennert@science-computing.de> <431C7131.3030506@rtr.ca>
In-Reply-To: <431C7131.3030506@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, you *should* be able to get the results you
are looking for (hdparm -I) by trying it this way:

    hdparm --Istdin </proc/ide/hdd/identify

Cheers
