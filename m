Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbUJZM7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbUJZM7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUJZM7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:59:05 -0400
Received: from webapps.arcom.com ([194.200.159.168]:43528 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262251AbUJZM7B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:59:01 -0400
Message-ID: <417E4A11.6050904@arcom.com>
Date: Tue, 26 Oct 2004 13:58:57 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Anderson <ryan@michonline.com>
CC: David Vrabel <dvrabel@arcom.com>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com> <20041026122632.GH10638@michonline.com>
In-Reply-To: <20041026122632.GH10638@michonline.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2004 12:59:24.0859 (UTC) FILETIME=[9E7C70B0:01C4BB5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Anderson wrote:
> 
> Well, I didn't think make-kpkg was doing anything horribly unexpected,
> so I didn't to test that.   I'll do a test run now to see what happens,
> though.

I think there might be problems when you use make-kpkg's 
--append-to-version option.  make-kpkg works out what the original 
version string should be and then tacks the extra bit on before 
overriding the original version.

More an argument for fixing make-kpkg to be less stupid I suppose.

Of course, the tool I'm using was derived from make-kpkg some time ago 
and could be broken and the proper (and newer) make-kpkg works fine.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
