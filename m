Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSEHIAE>; Wed, 8 May 2002 04:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSEHIAD>; Wed, 8 May 2002 04:00:03 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:9524 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S311752AbSEHIAC>; Wed, 8 May 2002 04:00:02 -0400
Date: Wed, 8 May 2002 09:49:00 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: James <jdickens@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Burn CDR's On 2.4.19pre8
Message-Id: <20020508094900.161451ec.kristian.peters@korseby.net>
In-Reply-To: <20020508072001.WWPH3647.mailhost.mil.ameritech.net@there>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James <jdickens@ameritech.net> wrote:
> I have read that Disk at Once mode works for writers that understand that 
> mode of writing, but the track at once is the one that is currently broken, 
> that explains why some us are complaining and others say that all is fine.

Do you mean cdrecord or the kernel ?

DiscAtOnce only works with newer models. I suspect that something is broken with late versions of cdrecord (>=1.10) cause burning with cdrdao works for other persons.
So adding "-dao" and "-pad" when you're burning audio to your commandline you should be on the safe side for now.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
