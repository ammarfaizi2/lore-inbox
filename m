Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269268AbTGJNgf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269274AbTGJNgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:36:35 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:52905 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S269268AbTGJNge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:36:34 -0400
Date: Thu, 10 Jul 2003 07:51:10 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Chua <jeff89@silk.corp.fedex.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22-pre4 ide module fix init_cmd640_vlb
In-Reply-To: <1057835714.8028.4.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307100749340.20705-200000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1197356979-1098354971-1057845070=:20705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1197356979-1098354971-1057845070=:20705
Content-Type: TEXT/PLAIN; charset=US-ASCII

On 10 Jul 2003, Alan Cox wrote:

> And stops it working for everyone else. The function does exist too. See
> drivers/ide/pci/cmd640.c

Isn't this just an issue of doing an export_symbol?

Here's a patch that does that exact thing, I haven't tested it though.

Regards
James

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

---1197356979-1098354971-1057845070=:20705
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.22-pre4-cmd640.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307100751100.20705@cafe.hardrock.org>
Content-Description: 
Content-Disposition: attachment; filename="2.4.22-pre4-cmd640.patch"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL3BjaS9jbWQ2NDAuY34JVGh1IEp1bCAx
MCAwNzo0NTozMCAyMDAzDQorKysgbGludXgvZHJpdmVycy9pZGUvcGNpL2Nt
ZDY0MC5jCVRodSBKdWwgMTAgMDc6NDU6MzAgMjAwMw0KQEAgLTEyNSw2ICsx
MjUsMTIgQEANCiBzdGF0aWMgaW50IGNtZDY0MF92bGIgPSAwOw0KIA0KIC8q
DQorICogZXhwb3J0IGluaXRfY21kNjQwX3ZsYiBmb3IgaWRlLWNvcmUNCisg
Ki8NCisgDQorRVhQT1JUX1NZTUJPTChpbml0X2NtZDY0MF92bGIpOw0KKw0K
Ky8qDQogICogQ01ENjQwIHNwZWNpZmljIHJlZ2lzdGVycyBkZWZpbml0aW9u
Lg0KICAqLw0KIA0K
---1197356979-1098354971-1057845070=:20705--
