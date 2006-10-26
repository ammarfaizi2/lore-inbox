Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423075AbWJZJzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbWJZJzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWJZJzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:55:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:48630 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423075AbWJZJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:55:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=unGO1Xr8GReaCUWxa1Irt+yEAW1nrxdHfoyB5RpVfzhbjR46woVIjTVXJcd2XPt5f8dZI4LdPEXXTD0CFrEBY3eAXVyUnlSezO0euNjZaZvuaKDQw1hB3qUtajW/y3I+ldx630IX2fVAgKooeojgOzMMGpOkyeC57ZTb+48+wG0=
Message-ID: <454085FF.1020402@gmail.com>
Date: Thu, 26 Oct 2006 05:55:11 -0400
From: FeRD <ferdnyc@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: David Woodhouse <dwmw2@infradead.org>,
       Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
References: <1161628327.19446.391.camel@pmac.infradead.org>	 <1161631091.16366.0.camel@localhost.localdomain>	 <1161633509.4994.16.camel@hughsie-laptop>	 <1161636514.27622.30.camel@shinybook.infradead.org>	 <1161710328.17816.10.camel@hughsie-laptop>	 <1161762158.27622.72.camel@shinybook.infradead.org>	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>	 <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
In-Reply-To: <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shem Multinymous wrote:
> Hi,
>
> On 10/25/06, David Woodhouse <dwmw2@infradead.org> wrote:
>> If you can summarise the bits I've missed in the meantime that would be
>> wonderfully useful
>
> OK. Looking at the current git snapshot:
[...]
> Why the reversed order, for example, in design_charge vs. charge_last?
> Following hwmon style, I think it should be
> s/design_charge/charge_design/
> s/manufacture_date/date_manufactured/
> s/first_use/date_first_used/
> s/design_voltage/voltage_design/
>
> s/charge_last/charge_last_full/ seems less ambiguous.
>
> s/^charge$/charge_left/ follows SBS and seems better.
Can I propose a further

s/left/remaining/

...flung at the above? Best to avoid "left" as anything but the opposite 
of "right", if disambiguation is the goal.

-FeRD

