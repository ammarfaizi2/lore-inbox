Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288128AbSAHQLd>; Tue, 8 Jan 2002 11:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288129AbSAHQLX>; Tue, 8 Jan 2002 11:11:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288128AbSAHQLN> convert rfc822-to-8bit;
	Tue, 8 Jan 2002 11:11:13 -0500
Date: Tue, 08 Jan 2002 08:10:15 -0800 (PST)
Message-Id: <20020108.081015.71089787.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: Dieter.Nuetzel@hamburg.de, andrea@suse.de, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, rml@tech9.net
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>
In-Reply-To: <20020108030431.0099F38C58@perninha.conectiva.com.br>
	<Pine.LNX.4.21.0201081153160.19178-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Tue, 8 Jan 2002 11:59:36 -0200 (BRST)
   
   On Tue, 8 Jan 2002, Dieter [iso-8859-15] Nützel wrote:
   
   > Andrew Morten`s read-latency.patch is a clear winner for me, too.
   
   AFAIK Andrew's code simply adds schedule points around the kernel, right? 
   
   If so, nope, I do not plan to integrate it.

No, this is the block I/O scheduler changes he did which up the
priority of reads wrt. writes so they do not sit around forever.

Franks a lot,
David S. Miller
davem@redhat.com
