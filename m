Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbSIWI2P>; Mon, 23 Sep 2002 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbSIWI2P>; Mon, 23 Sep 2002 04:28:15 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:11785 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S262687AbSIWI2O>;
	Mon, 23 Sep 2002 04:28:14 -0400
Message-ID: <3D8ED192.6060109@corvil.com>
Date: Mon, 23 Sep 2002 09:32:18 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jbradford@dial.pipex.com
CC: linux-kernel@vger.kernel.org
Subject: Re: hdparm -Y hangup
References: <200209211813.g8LIDEqQ001330@darkstar.example.net>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com wrote:
>>This seems like a bug in the ide driver not issuing a reset?
>>
>>On RH7.3 (2.4.18-3) if I do:
>>$ hdparm -Y /dev/hda
>>$ do stuff and disk spins up
>>$ hdparm -Y /dev/hda
>>$ everything hangs waiting for disk
> 
> It *IS* a bug, but only Mark Lord, (the hdparm maintainer), and I seem to care about it - everybody else says, "just do hdparm -y instead", which is missing the point.

Hrm, OK thanks for the info. Perhaps it should be removed
from hdparm or a (DANGEROUS) put beside the description
until it's fixed.

> 
> Incidently, I think you mean:
> 
> On RH7.3 (2.4.18-3) if I do:
> $ hdparm -y /dev/hda
> $ do stuff and disk spins up
> $ hdparm -Y /dev/hda
> $ everything hangs waiting for disk
> 
> with a lower case y for the first example.

No it seemed to wake up correctly the first time with -Y.
As you say -y works always.

> So, unless you, I, or Mark Lord fixes it, it stays broken :-).

cheers,
Pádraig.

