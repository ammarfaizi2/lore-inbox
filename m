Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbSKKKFW>; Mon, 11 Nov 2002 05:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265997AbSKKKFV>; Mon, 11 Nov 2002 05:05:21 -0500
Received: from relay01.rabobank.nl ([145.72.69.20]:30987 "HELO
	relay01.rabobank.nl") by vger.kernel.org with SMTP
	id <S265995AbSKKKFV>; Mon, 11 Nov 2002 05:05:21 -0500
X-Server-Uuid: d32dbd14-b86d-11d3-8c8e-0008c7bba343
X-Server-Uuid: 91077152-1bde-4e67-8480-731f07dac000
From: "Heusden van, FJJ (Folkert)" <F.J.J.Heusden@rn.rabobank.nl>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Subject: RE: random PID patch
Date: Mon, 11 Nov 2002 11:12:00 +0100
MIME-Version: 1.0
X-WSS-ID: 11D18E6D1073547-1319-02
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <11D18E6D1073547-1319@_rabobank.nl_>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've ported my random-PID-patch from 2.2.19 to 2.4.19.
> It should be downloadable from
> http://www.vanheusden.com/Linux/fp-2.4.19.patch.gz
> (or follow the link from
> http://www.vanheusden.com/Linux/kernel_patches.php3 )
RSK> hm
RSK> what's the point of random PIDs?

Sometimes, (well; frequently) programs that create temporary
files let the filename depend on their PID. A hacker could use
that knowledge. So if you know that the application that
you're starting uses the last PID+1, you could make sure that
that file already exists or create a symlink with that name or
whatsoever causing the application you're starting to do
things it's not supposed to. Like forcing suid apps to create
a file in the startup-scripts dir. or something.


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


