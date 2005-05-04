Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVEDJCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVEDJCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 05:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEDJCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 05:02:47 -0400
Received: from mail.portrix.net ([212.202.157.208]:41407 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261513AbVEDJCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 05:02:33 -0400
Message-ID: <42788F8C.6090908@ppp0.net>
Date: Wed, 04 May 2005 11:02:04 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Git-commits mailing list feed.
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>	 <426A4669.7080500@ppp0.net>	 <1114266083.3419.40.camel@localhost.localdomain>	 <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain>
In-Reply-To: <1114266907.3419.43.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020402030607000106090104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402030607000106090104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

David Woodhouse wrote:
> On Sat, 2005-04-23 at 16:30 +0200, Jan Dittmer wrote:
> 
>>>LASTRELEASE=`ls -rt .git/tags | grep -v git | grep -v MailDone | tail -1`
>>
>>My .git/tags is empty. At least 2.6.12-rc3 is not tagged so I wasn't sure
>>how to extract the latest release from the git tree.
>>ketchup was the most comfortable way.
> 
> 
> Nah, asking Linus to tag his releases is the most comfortable way.
> 

Here is an updated version of the script, working with paskys latest tree.

-- 
Jan

--------------020402030607000106090104
Content-Type: application/x-shellscript;
 name="snapjdi.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="snapjdi.sh"

IyEvYmluL3NoCgpTVEFHRT0vaG9tZS9qZGl0dG1lci9zcmMvbGsvd29yay8KCmNkIC9ob21l
L2pkaXR0bWVyL3NyYy9say9naXQKCiMgY2ctdXBkYXRlIG9yaWdpbiB8fCBleGl0IDEKClJF
TE5BTUU9YGNnLXRhZy1scyB8IGdyZXAgLXYgJ2dpdCcgfCB0YWlsIC1uMSB8IGN1dCAtZjFg
ClJFTENPTU09YGNnLXRhZy1scyB8IGdyZXAgLXYgJ2dpdCcgfCB0YWlsIC1uMSB8IGN1dCAt
ZjJgClNOQVBOQU1FPWBjZy10YWctbHMgfCBncmVwIC0tICIkUkVMTkFNRS1naXQiIHwgdGFp
bCAtbjEgfCBjdXQgLWYxYApTTkFQQ09NTT1gY2ctdGFnLWxzIHwgZ3JlcCAtLSAiJFJFTE5B
TUUtZ2l0IiB8IHRhaWwgLW4xIHwgY3V0IC1mMmAKQ1VSQ09NTT1gY2F0IC5naXQvSEVBRGAK
CiMgZWNobyByZWxlYXNlICAkUkVMTkFNRSAkUkVMQ09NTQojIGVjaG8gbGFzdHNuYXAgJFNO
QVBOQU1FICRTTkFQQ09NTSAKIyBlY2hvICRDVVJDT01NCgpbICIkU05BUENPTU0iID09ICIk
Q1VSQ09NTSIgXSAmJiBleGl0IDAKCgppZiBbICIkU05BUE5BTUUiID09ICIiIF07IHRoZW4K
CUNVUk5BTUU9IiRSRUxOQU1FLWdpdDEiCmVsc2UKCU9MREdJVE5VTT1gZWNobyAkU05BUE5B
TUUgfCBzZWQgcy9eLiotZ2l0Ly9gCglORVdHSVROVU09YGV4cHIgJE9MREdJVE5VTSArIDFg
CglDVVJOQU1FPSIkUkVMTkFNRS1naXQkTkVXR0lUTlVNIgpmaQoKI2VjaG8gbmV3c25hcCAg
JENVUk5BTUUgJENVUkNPTU0KCkNVUlRSRUU9JENVUkNPTU0KUkVMVFJFRT1gZ2l0LWNhdC1m
aWxlIHRhZyAkUkVMQ09NTSB8IGhlYWQgLW4xIHwgY3V0IC1mMiAtZCcgJ2AKIyBlY2hvICRD
VVJUUkVFOiRSRUxUUkVFCgojIFRoaXMgaXMsIHVuZm9ydHVuYXRlbHksIGluIGNocm9ub2xv
Z2ljYWwgb3JkZXIuIFdhbGtpbmcgdGhlIHRyZWUgd291bGQKIyBiZSBiZXR0ZXIuCmNnLWxv
ZyAkQ1VSVFJFRTokUkVMVFJFRSA+ICRTVEFHRS8kQ1VSTkFNRS5sb2cKY2ctZGlmZiAtciAk
Q1VSVFJFRTokUkVMVFJFRSB8IGd6aXAgLTkgPiAkU1RBR0UvcGF0Y2gtJENVUk5BTUUuZ3oK
Y2ctdGFnICRDVVJOQU1FICRDVVJDT01NCgplY2hvIE5ldyBTbmFwc2hvdCAkQ1VSTkFNRQo=
--------------020402030607000106090104--
