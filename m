Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTANOZZ>; Tue, 14 Jan 2003 09:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTANOZZ>; Tue, 14 Jan 2003 09:25:25 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:27230 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S262808AbTANOZX>;
	Tue, 14 Jan 2003 09:25:23 -0500
Message-ID: <3E242025.1030408@mvista.com>
Date: Tue, 14 Jan 2003 08:35:17 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: IPMI
References: <20030114084011.6AB412C466@lists.samba.org> <15907.55035.787654.77224@argo.ozlabs.ibm.com>
In-Reply-To: <15907.55035.787654.77224@argo.ozlabs.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added the following to the top of the document.  Do you have any
other comments on the document or this text?

The Intelligent Peripheral Management Interface, or IPMI, is a
standard for controlling intelligent devices that monitor a system.
It provides for dynamic discovery of sensors in the system and the
ability to monitor the sensors and be informed when the sensor's
values change or go outside certain boundaries.  It also has a
standardized database for field-replacable units (FRUs) and a watchdog
timer.

To use this, you need an interface to an IPMI controller in your
system (called a Baseboard Management Controller, or BMC) and
management software that can use the IPMI system.

-Corey

Paul Mackerras wrote:

>Rusty Russell writes:
>
>  
>
>>Telling me what IPMI is, and why I might need it, would be a good
>>thing...  Please, Corey, I'm feeling generation-gapped by the
>>acronyms...
>>    
>>
>
>There is a Documentation/IPMI.txt, which would serve as an excellent
>example of how _not_ to write a documentation file, should you ever
>decide to write a "Rusty's Unreliable Guide to Writing Kernel
>Documentation" and need an example to pillory.  I quote:
>
>
>  
>
>>			    The Linux IPMI Driver
>>			    ---------------------
>>				Corey Minyard
>>			    <minyard@mvista.com>
>>			      <minyard@acm.org>
>>
>>This document describes how to use the IPMI driver for Linux.  If you
>>are not familiar with IPMI itself, see the web site at
>>http://www.intel.com/design/servers/ipmi/index.htm.  IPMI is a big
>>subject and I can't cover it all here!
>>    
>>
>
>Maybe it can't all be covered here, but some basic explanation of what
>IPMI is and does is essential, even if just so that people who don't
>need IPMI can work that out.
>
>Paul.
>
>
>  
>


