Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSJ1Vr4>; Mon, 28 Oct 2002 16:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSJ1Vr4>; Mon, 28 Oct 2002 16:47:56 -0500
Received: from pc132.utati.net ([216.143.22.132]:32386 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261318AbSJ1Vrz> convert rfc822-to-8bit; Mon, 28 Oct 2002 16:47:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: 2.5.44: what's .tmp_export-objs for?
Date: Mon, 28 Oct 2002 11:54:16 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210281054.16008.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I accidentally did a 2.5.44 kernel build as root rather than my normal user, 
so I'm trying to see what clean steps I need to so (as root) to be able to 
build the tree again.  A normal make clean failed (permission denied deleting 
files), so I did an su and a make clean.  Exit back to normal user, make 
clean, life is good, do a make dep, and it complains about the directory 
.tmp_export-objs.

1) Why does the build process use a hidden directory?

2) Why isn't make clean removing something with "tmp" in the name?

Just curious,

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
