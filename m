Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTANOTm>; Tue, 14 Jan 2003 09:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTANOTm>; Tue, 14 Jan 2003 09:19:42 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:24414 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S262807AbTANOTl>;
	Tue, 14 Jan 2003 09:19:41 -0500
Message-ID: <3E241ECD.6000108@mvista.com>
Date: Tue, 14 Jan 2003 08:29:33 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI
References: <20030114084011.6AB412C466@lists.samba.org>
In-Reply-To: <20030114084011.6AB412C466@lists.samba.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this work, or would you like more detail?

config IPMI_HANDLER
       tristate 'IPMI top-level message handler'
       help
         This enables the central IPMI message handler, required for IPMI
         to work.  Note that you must have this enabled to enable any
         other IPMI things.  IPMI is a standard for managing sensors
         (temperature, voltage, etc.) in a system.  If you don't know
         what it is, your system probably doesn't have it and you can
         ignore this option.  See Documentation/IPMI.txt for more
         details on the driver.

-Corey

Rusty Russell wrote:

>From "make oldconfig":
>
>	*
>	* IPMI
>	*
>	IPMI top-level message handler (IPMI_HANDLER) [N/m/y/?] (NEW) ?
>	
>	This enables the central IPMI message handler, required for IPMI
>	to work.  Note that you must have this enabled to do any other IPMI
>	things.  See IPMI.txt for more details.
>	
>	IPMI top-level message handler (IPMI_HANDLER) [N/m/y/?] (NEW) 
>
>Telling me what IPMI is, and why I might need it, would be a good
>thing...  Please, Corey, I'm feeling generation-gapped by the
>acronyms...
>
>Thanks!
>Rusty.
>--
>  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>
>
>  
>


