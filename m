Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTLAWPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTLAWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:15:30 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:14265 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264231AbTLAWP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:15:28 -0500
Date: Mon, 1 Dec 2003 19:13:03 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: yocum@fnal.gov, nathans@sgi.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS for 2.4
Message-Id: <20031201191303.201b32c6.vmlinuz386@yahoo.com.ar>
In-Reply-To: <3FCBB790.1030503@jpl.nasa.gov>
References: <20031201062052.GA2022@frodo>
	<3FCBABD9.70309@fnal.gov>
	<3FCBB790.1030503@jpl.nasa.gov>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Dec 2003 13:50:08 -0800, Bryan Whitehead wrote:
>I'd like to "third" this request. Have a large amount of data here on 
>XFS with v2.4 kernel.
>
>Would be nice to be able to use pre-release 2.4 for testing without 
>having to manually hack in XFS paches from SGI for the odd reject...
>

Yes, exactly. 

Ok the XFS changes some vfs code, but works OK, and is in the -ac and -ck trees.

And another point is make the possiblility to add some patchs such as security
without hunks failed, and another funny hacks.

And the majority of distros include it.

Another vote.

chau,
 djgera


>Dan Yocum wrote:
>> Marcelo,
>> 
>> We (Fermilab) second this request.  We won't be touching 2.6 until it's 
>> really stable (read as, Red Hat comes out with an official distro that 
>> has it built in), and we already have *a lot* of XFS filesystems here 
>> (~>300TB) running on 2.4 kernels.  It would be very, very nice to have 
>> it in the 2.4 tree without having to pull it from SGI.
>> 
>> Thanks,
>> Dan
>> 
>> 
>> Nathan Scott wrote:
>> 
>>> Hi Marcelo,
>>>
>>> Please do a
>>>
>>>     bk pull http://xfs.org:8090/linux-2.4+coreXFS
>>>
>>> This will merge the core 2.4 kernel changes required for supporting
>>> the XFS filesystem, as listed below.  If this all looks acceptable,
>>> then please also pull the filesystem-specific code (fs/xfs/*)
>>>
>>>     bk pull http://xfs.org:8090/linux-2.4+justXFS
>>>
>>> cheers.
>>>
>> 
>
>
>-- 
>Bryan Whitehead
>SysAdmin - JPL - Interferometry and Large Optical Systems
>Phone: 818 354 2903
>driver@jpl.nasa.gov

-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
