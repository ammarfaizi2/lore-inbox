Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVGDR5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVGDR5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVGDR5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 13:57:38 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:44092 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261467AbVGDR5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 13:57:37 -0400
Message-ID: <42C9788F.50205@gentoo.org>
Date: Mon, 04 Jul 2005 18:57:35 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: =?UTF-8?B?RGF2aWQgR8OzbWV6?= <david@pleyades.net>,
       Robert Love <rml@novell.com>, John McCutchan <ttb@tentacle.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with inotify
References: <20050630181824.GA1058@fargo> <1120156188.6745.103.camel@betsy>	 <20050630193320.GA1136@fargo>	 <Pine.LNX.4.60.0506302138230.29755@hermes-1.csi.cam.ac.uk>	 <20050630204832.GA3854@fargo>	 <Pine.LNX.4.60.0506302158190.29755@hermes-1.csi.cam.ac.uk>	 <42C65A8B.9060705@gentoo.org>	 <Pine.LNX.4.60.0507022253080.30401@hermes-1.csi.cam.ac.uk>	 <42C72563.7040103@gentoo.org>	 <Pine.LNX.4.60.0507030053040.15398@hermes-1.csi.cam.ac.uk>	 <42C7BF37.9010005@gentoo.org> <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1120487242.11399.5.camel@imp.csi.cam.ac.uk>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> )-:  I have addressed the only things I can think off that could cause
> the oops and below is the resulting patch.  Could you please test it?

Yeah!! After removing I_WILL_FREE stuff, that fixed both the oops *and* the
hang. Everything works nicely now.

Thanks a million!

Daniel
