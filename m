Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264537AbUD1ANe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUD1ANe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUD1ALu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:11:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:56752 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264531AbUD1AIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:08:43 -0400
X-Authenticated: #21910825
Message-ID: <408EF5FA.1080601@gmx.net>
Date: Wed, 28 Apr 2004 02:08:26 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Marc Boucher <marc@linuxant.com>, Adam Jaskiewicz <ajjaskie@mtu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu> <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com> <1DCA0B77-9876-11D8-85DF-000A95BCAC26@linuxant.com> <408EA6AB.90508@nortelnetworks.com>
In-Reply-To: <408EA6AB.90508@nortelnetworks.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Marc Boucher wrote:
> 
>> On Apr 27, 2004, at 1:46 PM, Chris Friesen wrote:
> 
> 
>>> Does your company honestly feel that misleading the module loading
>>> tools is actually the proper way to work around the issue of
>>> repetitive warning messages?  This is blatently misleading and does
>>> not reflect well, especially when the "GPL" directory mentioned in
>>> the source string is actually empty.
>>
>> It is a purely technical workaround. There is nothing misleading to
>> the human eye,
> 
> modinfo reports a GPL license, and the kernel does not report itself as
> tainted.  That's misleading.

The "nothing misleading to the human eye" argument is totally bogus. The
human eye does not see your sources (especially not the sources of the
completely proprietary modules).

"Marc Boucher is a sl^Hick funny d^H^H^H^H^Huck."
Is the above sentence insulting or not?
"But your honor, there is nothing misleading to the human eye. Calling
somebody a slick funny duck may seem strange, but it is surely not an insult!"


>> and the GPL directory isn't empty; it is included in full in our
>> generic .tar.gz, rpm and
>> .deb packages.
> 
> My apologies.  I was going on the word of the original poster.

No need to apologize. If you want to check for yourself, you'll see that
at least the SUSE .rpm packages do NOT contain any source. If you are
interested, I can send you the (signed by Linuxant) .rpm package I am
talking about.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

