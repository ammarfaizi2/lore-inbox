Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSC2Smt>; Fri, 29 Mar 2002 13:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311024AbSC2Smk>; Fri, 29 Mar 2002 13:42:40 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:13011 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S310660AbSC2SmZ>; Fri, 29 Mar 2002 13:42:25 -0500
Date: Fri, 29 Mar 2002 13:42:20 -0500
From: Grogan <2grogan@sympatico.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Message-Id: <20020329134220.7019b128.2grogan@sympatico.ca>
In-Reply-To: <5.1.0.14.2.20020328200457.03dfda90@pop.cus.cam.ac.uk>
Organization: PC911
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

>I don't know what version of mc they are talking about, but in my version of mc >("The Midnight Commander 4.5.51") I can use the view command on any file on >the NTFS partition without it trying to execute the file. The files are all showing in >green, with the asterisk.

Sorry for the second post, but I took a look at the .tar.gz issue in midnight commander. It doesn't appear to have anything to do with the executable permission, the problem is that the filesystem isn't writable. I get the same flood of errors on the console trying to tar xvzf the file as I do in mc...

"Could not create file: No such file or directory"

So it's not a problem with mc. There's no problem if I use the --directory switch with the tar command to specify a writable location to extract to. I also can copy the same file, to my home directory and retain the same permissions, and extract it using mc just fine.

Grogan

