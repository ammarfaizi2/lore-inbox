Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130719AbQKCWiI>; Fri, 3 Nov 2000 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131099AbQKCWh6>; Fri, 3 Nov 2000 17:37:58 -0500
Received: from mail02.onetelnet.fr ([213.78.0.139]:59447 "EHLO
	mail02.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S129559AbQKCWhr>; Fri, 3 Nov 2000 17:37:47 -0500
Message-ID: <3A034BF6.F81B5952@onetelnet.fr>
Date: Sat, 04 Nov 2000 00:36:22 +0100
From: FORT David <epopo@onetelnet.fr>
Organization: Derriere les rochers Networks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.0test10 not booting on 486 laptop
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.4.0test10 bootup, i got the "Loading" message, then "Uncompressing

kernel...", i can see quickly "Booting.....", and it does it: it reboots.

My last kernel was 2.4.0test7, and was not exibiting the problem. I've

recheck my .config, but it's the same as for 2.4.0test7.

My gcc:

[root@Djinn linux]# gcc -v
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux/2.95.2/specs
gcc version 2.95.2 19991024 (release)
[root@Djinn linux]#

according to Changes may be good.

The laptop is a 486dx2@40 compaq contura 400cx, two thing that may be

important: it has early cpuid support(many changes occured in this

area recently), and it doesn't have any PCI bus(but kernel is compiled

with it, in order to have Card drivers).

--
%-------------------------------------------------------------------------%
% FORT David,                                                             %
% 7 avenue de la morvandière                                   0240726275 %
% 44470 Thouare, France                                epopo@onetelnet.fr %
% ICU:78064991   AIM: enlighted popo             fort@irin.univ-nantes.fr %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/flashed PHP3 coming soon   |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlighted....            |  ^^-^^                        %
%                           http://ibonneace.dnsalias.org/ when connected %
%-------------------------------------------------------------------------%



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
