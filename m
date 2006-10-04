Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161808AbWJDRHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161808AbWJDRHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161804AbWJDRHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:07:50 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:664 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161672AbWJDRHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:07:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tZdADKS/2MCrOfpW5nuXitLAnMqlAYbZOV+oXpIExRB9DqYslzzw1uWDDhwz10ID8dGC6mCCWqw+GAkQSOH8GJFMqYk+Y2vTBXzCPLpY+80J3G+8whEGqlLEygTZZGVYQ5Nx0InMPe8Pqf+FyJjB/ZYVVclOQvbGv8sFxI+WClM=
Message-ID: <653402b90610041007w7ec4eca4g806c307c47075a13@mail.gmail.com>
Date: Wed, 4 Oct 2006 17:07:46 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2.6.18 V8] drivers: add LCD support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061004094934.b780c8c5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061004180615.6a81e4c7.maxextreme@gmail.com>
	 <20061004094934.b780c8c5.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
>
> Couldn't you make the class be "auxdisplay" also?
>

I don't really know what would be the best. I think if anyone adds a
driver for any other kind of display (example: OLED), he/she can
create a oledclass, that maybe need more funcionality than just the
simple lcdclass.
