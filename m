Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRCEL3x>; Mon, 5 Mar 2001 06:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRCEL3o>; Mon, 5 Mar 2001 06:29:44 -0500
Received: from terra.khb.hu ([195.228.214.241]:400 "EHLO terra.khb.hu")
	by vger.kernel.org with ESMTP id <S129159AbRCEL3f> convert rfc822-to-8bit;
	Mon, 5 Mar 2001 06:29:35 -0500
Date: Mon, 5 Mar 2001 12:27:15 +0100 (CET)
From: Holluby István istvan.holluby@khb.hu 
	<isti@khb.hu>
Reply-To: <istvan.holluby@khb.hu>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: <vandrove@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [acme@conectiva.com.br: Re: mke2fs /dev/loop0]
In-Reply-To: <20010228103900.H24856@conectiva.com.br>
Message-ID: <Pine.LNX.4.33.0103051148190.539-100000@cica.khb.hu>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BPEST0/KHB/HU(Release 5.0.4 |June 8, 2000) at 03/05/2001
 12:41:02 PM,
	Serialize by Router on BPEST0/KHB/HU(Release 5.0.4 |June 8, 2000) at 03/05/2001
 12:41:03 PM,
	Serialize complete at 03/05/2001 12:41:03 PM
Content-Transfer-Encoding: 8BIT
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Feb 2001, Arnaldo Carvalho de Melo wrote:

> I'm interested if this is directly related to IPX, Petr is the guy for
> NCPfs, can you please send us more details about this problem? Hangs? Data
> corruption? what?
>
> - Arnaldo


	The problem was simply, that I couldn't  cd to a directory.
"File exist, but couldn't be stat-ed" or something similar was the
message.

	Now I think, that it was my fault. I think, I forgot to compile
one of the charsets into the kernel, and this dir had strange filenames.
I haven't had time to check it thou.



   Petr Vandrovec       vandrove@vc.cvut.cz  wrote:

> Can you be more specific? ncpfs should (and AFAIK does) compile out
> of the box

On glibc-2.2.2 		header files of select changed. So it does not
compile cleanly. If I remember well, a define called number_of_open or
similar was also missing. I am not sure in it thou. It might have been
some other program.

thanks

Holluby István
(istvan.holluby@khb.hu)


