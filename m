Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289597AbSBJNSR>; Sun, 10 Feb 2002 08:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289600AbSBJNSG>; Sun, 10 Feb 2002 08:18:06 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:62594 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S289597AbSBJNSA>; Sun, 10 Feb 2002 08:18:00 -0500
Date: Sun, 10 Feb 2002 08:04:48 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, dz@debian.org
Subject: APM fix from -pre7 seems to break "Dell laptop support"
Message-ID: <20020210130447.GA1001@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	LKML <linux-kernel@vger.kernel.org>, dz@debian.org
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202041743180.14205-100000@freak.distro.conectiva>
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_I8K=y and Massimo Dal Zotto's i8k utilities, it's necessary
for me to revert Stephen Rothwell's 2.4.17-APM.1 patch that went into
18-pre7.  If I don't, CPU temperature readings jump around erratically
and the fans come on at the wrong temperatures.  I reported this to
Stephen and on lkml at the time -pre7 came out, but the problem is
still there in -pre9.  If the patch offers real benefits to non-Dell
folk I guess I can just continue reverting...

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
