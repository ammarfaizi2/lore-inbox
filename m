Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278336AbRJSIId>; Fri, 19 Oct 2001 04:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278337AbRJSIIO>; Fri, 19 Oct 2001 04:08:14 -0400
Received: from toad.com ([140.174.2.1]:43535 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278336AbRJSIIL>;
	Fri, 19 Oct 2001 04:08:11 -0400
Message-ID: <3BCFDFA1.FF7661FE@mandrakesoft.com>
Date: Fri, 19 Oct 2001 04:09:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com> <20011018121318.17949@smtp.adsl.oleane.com> <9qomdf$obo$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:
> And a version field! Please add a version field right to the
> beginning. This would make supporting legacy drivers in later versions
> _much_ easier.

That's something to be done in a Windows not Linux driver.

This is not a structure that is directly exposed to userspace, so it
doesn't need to be versioned.

We don't really support legacy drivers in the first place, much less
take up space with versions in structs everywhere..

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
