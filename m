Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTLOLU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTLOLU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:20:59 -0500
Received: from fmr99.intel.com ([192.55.52.32]:7564 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262546AbTLOLU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:20:57 -0500
Message-ID: <3FDD9915.3010801@intel.com>
Date: Mon, 15 Dec 2003 13:20:53 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Greg KH <greg@kroah.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <20031215100724.GA1950@kroah.com>
In-Reply-To: <20031215100724.GA1950@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>>Hi,
>>PCI-Express platforms will soon appear on the market. It is worth to
>>support it.
>>    
>>
>
>Yes it is worth it, any chance to get access to hardware to test this
>out on?
>  
>
If it were up to me, I will give away full specs and test platforms. But 
it is not...

>No, we need to get this into 2.6 first.  Can you please forward port
>this to 2.6, clean up the formatting and address the issues everyone
>else has made so far and post it?
>  
>
I will. It take some time, I did not installed 2.6 yet.

>> * command line argument "pci=exp" to force PCI Express, similar to "conf1" and "conf2"
>>    
>>
>
>We should be able to do this automatically, and not force this on the
>boot command line, correct?
>  
>
Yes. Default is autodetect. Command line is to suppress autodetection.

>How about information on how to detect it as per chipset type?  We need
>to do this automatically some how.
>+ * 
>+ * There is no standard method to recognize presence of PCI Express,
>  
>
>
>Are you sure?  I thought there was (don't have my spec in front of me
>right now...)
>  
>
I thought this way also. But I found that it is not. You may know 
several chipsets,
and do per-chipset stuff, but there is no generic procedure. At least 
authors of PCI-E
don't know (it is nice to have access to the authors ;-) ).

Vladimir.

