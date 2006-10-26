Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423522AbWJZOaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423522AbWJZOaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423523AbWJZOaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:30:35 -0400
Received: from dvhart.com ([64.146.134.43]:10218 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1423522AbWJZOaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:30:35 -0400
Message-ID: <4540C678.2060106@mbligh.org>
Date: Thu, 26 Oct 2006 07:30:16 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: admin@prnet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18: unable to handle kernel paging request at virtual address
      e5e9ec24
References: <58488.212.24.212.169.1161860570.squirrel@server.prnet.org>
In-Reply-To: <58488.212.24.212.169.1161860570.squirrel@server.prnet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

admin@prnet.org wrote:
> Hi,
> 
> I get repeated times (approximately every 2 days) a similiar exception
> with kernel
> 2.6.18 ?
> 
> I never noticed a problem like this using 2.6.17.
> 
> Does anyone have any suggestion what could go wrong ?

Yes, this:

> Tainted: P      VLI

Binary modules loaded. Don't do that.
