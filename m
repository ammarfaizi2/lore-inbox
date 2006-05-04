Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWEDVpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWEDVpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWEDVpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:45:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:5191 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWEDVpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:45:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d3t1OZGjMgtMg4cWAbMDsA7c/oLm060ZaHONWtyavD1AdZC5EY8ewPd9AvBm10/7Ev72TZRgBQYcNoS/5LuWVGa4si1Fb7B4UZGqmvvC9kEpp67xb8UxbZYWBSq0PQ+/PXJ2V+w26xP5eX5a4jZPpbr4wBlsZeFGVgEHP/AiSHM=
Message-ID: <445A75D8.9040104@gmail.com>
Date: Fri, 05 May 2006 05:44:56 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: grfgguvf.29601511@bloglines.com, linux-kernel@vger.kernel.org
Subject: Re: Weird framebuffer bug?
References: <1146777893.3982259993.25862.sendItem@bloglines.com> <200605042129.k44LTSXa022256@turing-police.cc.vt.edu>
In-Reply-To: <200605042129.k44LTSXa022256@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Thu, 04 May 2006 21:24:53 -0000, grfgguvf.29601511@bloglines.com said:
>> I am having a really strange bug where every fifth or so vertical line
>> is not displayed when running X using the framebuffer (so the right fifth
>> of the screen is also left black). And it's not the monitor settings. If the
>> image is stretched to fill the screen the lines are still omitted (It's an
>> LCD and it interpolates the lines so the whole image looks blurred).
> 
> I'll bite.  Have you tried using a configuration that specifies the *actual*
> LCD resolution so it doesn't have to interpolate?

And if you can't specify the actual resolution with vesafb, try nvidiafb.

Tony
