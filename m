Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286264AbRLTOcZ>; Thu, 20 Dec 2001 09:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286261AbRLTOcF>; Thu, 20 Dec 2001 09:32:05 -0500
Received: from t2.redhat.com ([199.183.24.243]:35310 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S286260AbRLTObz>; Thu, 20 Dec 2001 09:31:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011220145328.C16650@unthought.net> 
In-Reply-To: <20011220145328.C16650@unthought.net>  <200112100544.fBA5isV223458@saturn.cs.uml.edu> <E16GnIg-0000V5-00@starship.berlin> <20011220110936.A18142@atrey.karlin.mff.cuni.cz> <200112201338.OAA23947@mail48.fg.online.no> 
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: svein.ove@aas.no,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: File copy system call proposal 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Dec 2001 14:31:27 +0000
Message-ID: <3794.1008858687@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jakob@unthought.net said:
>  Take a look at Win32, they have it.

Which is partly why when you want to copy a large file on an SMB-exported
file system, the client host doesn't have to actually read it all and write 
it back across the network - it can just issue a copyfile request.

--
dwmw2


