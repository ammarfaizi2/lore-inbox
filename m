Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276364AbRJKODf>; Thu, 11 Oct 2001 10:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276370AbRJKODZ>; Thu, 11 Oct 2001 10:03:25 -0400
Received: from mail1.dexterus.com ([212.95.255.99]:41997 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S276364AbRJKODR>; Thu, 11 Oct 2001 10:03:17 -0400
Message-ID: <3BC5A691.9F7E826@dexterus.com>
Date: Thu, 11 Oct 2001 15:02:57 +0100
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Lost Partition
In-Reply-To: <Pine.GSO.4.21.0110110955391.22698-100000@weyl.math.psu.edu>
Content-Type: multipart/mixed;
 boundary="------------07CD123EDF172CD4F9ACAD80"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------07CD123EDF172CD4F9ACAD80
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:
> 
> On Thu, 11 Oct 2001, Vincent Sweeney wrote:
> 
> > No luck I'm afraid. The patch applied successfully bit I still get
> > exactly the same problem.
> 
> Please, do the following:
> 
> dd if=/dev/hdb of=p0 bs=512 count=1
> dd if=/dev/hdb of=p1 bs=512 count=1 skip=1076355
> 
> and mail the contents of p0 and p1.

Files p0 and p1 attached.
--------------07CD123EDF172CD4F9ACAD80
Content-Type: application/octet-stream;
 name="p0"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="p0"

+jPAjtC8AHyL9FAHUB/7/L8ABrkAAfOl6h0GAAC+vgezBIA8gHQOgDwAdRyDxhD+y3XvzRiL
FItMAovug8YQ/st0GoA8AHT0vosGrDwAdAtWuwcAtA7NEF7r8Ov+vwUAuwB8uAECV80TX3MM
M8DNE0917b6jBuvTvsIGv/59gT1VqnXHi/XqAHwAAEludmFsaWQgcGFydGl0aW9uIHRhYmxl
AEVycm9yIGxvYWRpbmcgb3BlcmF0aW5nIHN5c3RlbQBNaXNzaW5nIG9wZXJhdGluZyBzeXN0
ZW0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABppPWyAACAAQEAgv4/QT8AAACDLRAAAAABQgX+///CLRAAFskfAQAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVao=
--------------07CD123EDF172CD4F9ACAD80
Content-Type: application/octet-stream;
 name="p1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="p1"

biZ1YWN1dGU7IEVkaWNpJm9hY3V0ZTtuKSwgeSBsYXMgaW0mYWFjdXRlO2dlbmVzIHNvbiBy
ZWVtcGxhemFkYXMgcG9yIGljb25vcy4gU2lydmUgcGFyYSBxdWl0YXIgbG9zIGljb25vcyBk
ZSBzdXN0aXR1Y2kmb2FjdXRlO24geSB2ZXIgbGFzIGltJmFhY3V0ZTtnZW5lcyByZWFsZXMg
ZGUgbGEgcCZhYWN1dGU7Z2luYS4KCjxMST48Qj5JbXByaW1pcjwvQj4KPEJSPlNpcnZlIHBh
cmEgaW1wcmltaXIgZWwgY29udGVuaWRvIGRlIGxhIHAmYWFjdXRlO2dpbmEgcXVlIGVzdCZh
YWN1dGU7IGVuIHBhbnRhbGxhLiBTZSBhYnJlIHVuIGN1YWRybyBkZSBkaSZhYWN1dGU7bG9n
byBlbiBlbCBxdWUgcHVlZGVuIGVsZWdpcnNlIGxhcyBjYXJhY3RlciZpYWN1dGU7c3RpY2Fz
IGRlIGxhIGltcHJlc2kmb2FjdXRlO24uCgo8TEk+PEI+U2VndXJpZGFkPC9CPgo8QlI+U2ly
dmUgcGFyYSB2ZXIgbGEgcCZhYWN1dGU7Z2luYSA8Qj5JbmZvcm1hY2kmb2FjdXRlO24gc29i
cmUgc2VndXJpZGFkPC9CPiwgZW4gbGEgcXU=
--------------07CD123EDF172CD4F9ACAD80--

