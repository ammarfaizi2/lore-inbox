Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSKKKN7>; Mon, 11 Nov 2002 05:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266032AbSKKKN7>; Mon, 11 Nov 2002 05:13:59 -0500
Received: from relay01.rabobank.nl ([145.72.69.20]:55569 "HELO
	relay01.rabobank.nl") by vger.kernel.org with SMTP
	id <S266006AbSKKKN6>; Mon, 11 Nov 2002 05:13:58 -0500
X-Server-Uuid: d32dbd14-b86d-11d3-8c8e-0008c7bba343
X-Server-Uuid: 91077152-1bde-4e67-8480-731f07dac000
From: "Heusden van, FJJ (Folkert)" <F.J.J.Heusden@rn.rabobank.nl>
To: "Tomas Szepe" <szepe@pinerecords.com>,
       "Heusden van, FJJ (Folkert)" <F.J.J.Heusden@rn.rabobank.nl>
cc: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Subject: RE: random PID patch
Date: Mon, 11 Nov 2002 11:20:39 +0100
MIME-Version: 1.0
X-WSS-ID: 11D18CF11074110-971-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <11D18CF11074110-971@_rabobank.nl_>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sometimes, (well; frequently) programs that create temporary
> files let the filename depend on their PID. A hacker could use
> that knowledge. So if you know that the application that
> you're starting uses the last PID+1, you could make sure that
> that file already exists or create a symlink with that name or
> whatsoever causing the application you're starting to do
> things it's not supposed to. Like forcing suid apps to create
> a file in the startup-scripts dir. or something.
TS> How about I create 2^15 symlinks then?
TS> Really, the only true solution to this problem is to fix the apps.

True. But until ALL applications are fixed and until this bug is no
longer written, this patch can help...

I agree, though,  that it should not be implemented in the main-
kernel. Still, it can be usefull.


================================================
De informatie opgenomen in dit bericht kan vertrouwelijk zijn en 
is uitsluitend bestemd voor de geadresseerde. Indien u dit bericht 
onterecht ontvangt, wordt u verzocht de inhoud niet te gebruiken en 
de afzender direct te informeren door het bericht te retourneren. 
================================================
The information contained in this message may be confidential 
and is intended to be exclusively for the addressee. Should you 
receive this message unintentionally, please do not use the contents 
herein and notify the sender immediately by return e-mail.


