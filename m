Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWIANgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWIANgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 09:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWIANgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 09:36:06 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:37265 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751405AbWIANgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 09:36:04 -0400
Message-ID: <44F838E2.2010908@student.ltu.se>
Date: Fri, 01 Sep 2006 15:42:58 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: akpm@osdl.org, sfrench@samba.org, linux-cifs-client@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 1/2] fs/cifs: Converting into generic boolean
References: <44F83356.20207@student.ltu.se> <Pine.LNX.4.61.0609011518030.21826@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609011518030.21826@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>--- a/fs/cifs/asn1.c	2006-09-01 01:24:45.000000000 +0200
>>+++ b/fs/cifs/asn1.c	2006-09-01 02:43:09.000000000 +0200
>>@@ -457,7 +457,7 @@ decode_negTokenInit(unsigned char *secur
>>unsigned char *sequence_end;
>>unsigned long *oid = NULL;
>>unsigned int cls, con, tag, oidlen, rc;
>>-	int use_ntlmssp = FALSE;
>>+	int use_ntlmssp = false;
>>    
>>
>
>Should not this become 'bool use_ntlmssp'? Possibly in a later patch?
>  
>
I would like to, but there has been complaints on changing 'int''s into 
'bool''s, so until there is a more formal decision on this...
Of course I would be happy to make a 'int'->'bool'-patch if a maintainer 
wants it.

>
>Jan Engelhardt
>  
>
Richard Knutsson

