Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWH1MTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWH1MTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWH1MTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:19:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:5183 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964848AbWH1MTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:19:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P7hP/ArFKr/V4s559IZsJSrY8ScuqhFJDrQM8B+dqPiJOqPdnpb5xQeaxtmteDoC4FRCKNd8DDO8WMXeS7VN9pPiVDtqf2eA7hh6SALvm0+TYXrcPHQmfJfgMabnTaiUMJ4duVJEH0A5d4o4hyWZNGP6uJXatWxLNWk+9HC3KGY=
Message-ID: <9e0cf0bf0608280519y7a9afcb9od29494b9cacb8852@mail.gmail.com>
Date: Mon, 28 Aug 2006 15:19:36 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Cc: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com, Matt_Domsch@dell.com
In-Reply-To: <44F29BCD.3080408@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <445B5524.2090001@gmail.com> <200608272116.23498.ak@suse.de>
	 <44F1F356.5030105@zytor.com> <200608272254.13871.ak@suse.de>
	 <44F21122.3030505@zytor.com> <44F286E8.1000100@gmail.com>
	 <44F2902B.5050304@gmail.com> <44F29BCD.3080408@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Totally pointless since we're in 16-bit mode (as is the "incl %esi")...
> I guess it's "better" in the sense that if we run out of that we'll
> crash due to a segment overrun... maybe (some BIOSes leave us
> unknowningly in big real mode...)

So leave as is? Loading address into esi and reference as si?
Or modify the whole code to use 16 bits?

Best Regards,
Alon Bar-Lev.
