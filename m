Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285424AbSALKSr>; Sat, 12 Jan 2002 05:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSALKSh>; Sat, 12 Jan 2002 05:18:37 -0500
Received: from xena.tvnetwork.hu ([80.95.64.68]:34702 "EHLO xena.tvnetwork.hu")
	by vger.kernel.org with ESMTP id <S285424AbSALKS1> convert rfc822-to-8bit;
	Sat, 12 Jan 2002 05:18:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: "[joco]" <fejes@tvnetwork.hu>
To: linux-kernel@vger.kernel.org
Subject: noexec
Date: Sat, 12 Jan 2002 11:18:28 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02011211182802.00430@carma>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think you should implement the noexec feature in the (v)fat module. In 
former versions it worked, and there were no executable attributes on the 
files. Now noexec takes no effect, and the undocumented showexec parameter to 
the fat module still makes the .com, .exe, .bat files executable. If one has 
no dos emulator, then it's annoying. Maybe there should be a binfmt_dos stuff 
which, when compiled, makes executable files have the executable filemode, 
but under no other circumstances.

-- 
:|[ [joco] at IRCNet * fejes@tvnetwork.hu * http://jocoweb.fw.hu/ ]|:
:|[ fingerprint ABEF A08E 7F5A 38AC EA9B B614 BC9F 64DD EB6A 6818 ]|:
