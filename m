Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbQLDEa3>; Sun, 3 Dec 2000 23:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQLDEaT>; Sun, 3 Dec 2000 23:30:19 -0500
Received: from lantana.tenet.res.in ([206.103.12.154]:56585 "EHLO
	lantana.iitm.ernet.in") by vger.kernel.org with ESMTP
	id <S129465AbQLDEaO>; Sun, 3 Dec 2000 23:30:14 -0500
Date: Mon, 4 Dec 2000 09:32:58 +0530 (IST)
From: K Ratheesh <rathee@lantana.tenet.res.in>
To: linux-kernel@vger.kernel.org
Subject: Linux for local languages - patch 
Message-ID: <Pine.LNX.4.10.10012040923020.29288-100000@lantana.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am Ratheesh , student of Indian Institute of Technology Madras. 

I am working on enabling Linux console for Local languages. As the current
PSF format doesn't support variable width fonts , I have made a patch in
the console driver so that it will load a user defined multi-glyph mapping
table so that multiple glyphs can be displayed for a single character
code. All editing operations will also be taken care of.

Further, for Indian languages, there are various consonant/vowel modifiers
which result in complex character clusters. So I have extended the patch
to load user defined context sensitive parse rules for glyphs /
character codes as well. Again, all editing operations will behave
according to the parse rule specifications.

Even though the patch has been developed keeping Indian languages in mind,
I feel it will be applicable to many other languages (for eg. Chinese)
which require wider fonts on console or user defined parsing at I/O level.

Currently I have developed the patch for Kernel versions 2.2.14 and and am
in the process of making it for 2.2.16 and 2.2.17. I request people to
try out this patch and give comments and suggestions to me. 

Those who want to try out this patch can send mail to me in the address
rathee@lantana.iitm.ernet.in or to indlinux-iitm@lantana.iitm.ernet.in 

The package , containing the patch , some documentation ,utilities and
sample files will come around 100 KB. 


Thanking you,

Ratheesh

---
Ratheesh K 
Res: 242 Tapti, IIT Madras , Chennai-36, India  Tel:+91-44-4459089
Lab: Distributed Systems& Optical Networks Lab,IIT Madras Tel:+91-44-4458353
www.ratheeshkvadhyar.com    ratheesh@rediffmail.com







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
