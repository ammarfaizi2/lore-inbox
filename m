Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWIOQPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWIOQPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWIOQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:15:09 -0400
Received: from kurby.webscope.com ([204.141.84.54]:33196 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751655AbWIOQPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:15:06 -0400
Message-ID: <450AD0CA.7080800@linuxtv.org>
Date: Fri, 15 Sep 2006 12:11:54 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ang Way Chuang <wcang@nrg.cs.usm.my>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Marcel Siegert <mws@linuxtv.org>
Subject: Re: [patch 29/37] dvb-core: Proper handling ULE SNDU length of 0
References: <20060906224631.999046890@quad.kroah.org> <20060906225740.GD15922@kroah.com> <45016909.4080908@linuxtv.org> <20060908172944.GA1254@suse.de>
In-Reply-To: <20060908172944.GA1254@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Sep 08, 2006 at 08:58:49AM -0400, Michael Krufky wrote:
>> Greg KH wrote:
>>> -stable review patch.  If anyone has any objections, please let us know.
>> Greg,
>>
>> Can we hold off on this until the 2.6.17.13 review cycle?  This patch
>> has not been sent to the linux-dvb mailing list, it has not been
>> reviewed or tested except for the Author and Marcel.
> 
> Yes, I've now moved it, thanks.

Marcel Siegert and I spoke about this today --  We are doing things a
bit differently for 2.6.18 and later, but this patch is appropriate for
2.6.17.y

Please apply it for the next -stable kernel release.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>


