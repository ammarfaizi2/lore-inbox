Return-Path: <linux-kernel-owner+w=401wt.eu-S932750AbWLTUgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbWLTUgB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLTUgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:36:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:17104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbWLTUgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:36:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BJg5YTz0iFjbUsJyVV6W/ELpMpxayZd7LwkwruNllA9p7Tt2rMqZzuZiCMfXs70iSq8m5OShLaPq5VmjU9nb1p4BMaaFiRjObKpTMrlo6oq0rPVXDvPY/BEAtreQP1vhSFMhCmKtN7T8VFbo40oG0n3kEKKMbFuAWImQTGU9lf4=
Message-ID: <45899EFF.8010906@gmail.com>
Date: Wed, 20 Dec 2006 12:37:19 -0800
From: walt <w41ter@gmail.com>
Organization: none
User-Agent: Thunderbird 3.0a1 (X11/20061220)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>,
       "Andrew J. Barr" <andrew.james.barr@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda
 changes (was Re: BUG on 2.6.20-rc1 when using gdb)
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org> <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org> <20061220183521.GA28900@slug> <45898D4E.1030507@goop.org>
In-Reply-To: <45898D4E.1030507@goop.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Frederik Deweerdt wrote:
>> Same problems here with 2.6.20-rc1-mm1 (ie with the %gs->%fs patch).
>> It seems to me that the problem comes from the EFL_OFFSET no longer
>> beeing accurate.
>> The following patch fixes the problem for me.
>>   
> 
> Thanks Frederik; that's exactly the kind of thing I thought it might
> be.  I wonder if there's some way we can make this more robust
> though...  Does this work for you?  I did a slightly larger cleanup
> which should make it less fragile and more comprehensible.
<patch snipped>

Hi Jeremy,

Your patch works fine for me.  (I didn't try the first patch, but I
will if anyone wants.)  Thanks!
