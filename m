Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277212AbRJINpY>; Tue, 9 Oct 2001 09:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277217AbRJINpT>; Tue, 9 Oct 2001 09:45:19 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4584 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277212AbRJINpI>; Tue, 9 Oct 2001 09:45:08 -0400
Message-ID: <3BC2FF97.4090204@wipro.com>
Date: Tue, 09 Oct 2001 19:15:59 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Kirill Ratkin <kratkin@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: No locking is needed ... why?
In-Reply-To: <Pine.LNX.4.33L.0110091036530.2847-100000@imladris.rielhome.conectiva>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>
>Each CPU has its own data structure here. This means no
>other CPU will touch this queue (they have their own)
>so there is nobody we could ever race against.
>
We would still require locking or interrupt disabling if this data is used
from an interrupt context (due to re-enterency issues), wouldn't we Rik?

Regards,
Balbir

>
>
>regards,
>
>Rik
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
