Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUJSB5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUJSB5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUJSB5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:57:16 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:59063 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268280AbUJSB4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:56:54 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_19_Oct_2004_01_56_47_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041019015647.6963790073@merlin.emma.line.org>
Date: Tue, 19 Oct 2004 03:56:47 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.233, 2004-10-19 03:56:30+02:00, matthias.andree@gmx.de
  5 new addresses

ChangeSet@1.232, 2004-10-19 03:43:09+02:00, matthias.andree@gmx.de
  Support blanks and underscores as word separators in Signed-off-by: tags.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.203/shortlog	2004-10-14 08:58:06 +02:00
+++ 1.205/shortlog	2004-10-19 03:56:29 +02:00
@@ -1009,6 +1009,7 @@
 'jakub:redhat.com' => 'Jakub Jelínek',
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
+'james.smart:emulex.com' => 'James Smart',
 'james:cobaltmountain.com' => 'James Mayer',
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
@@ -1067,7 +1068,9 @@
 'jejb:jet.(none)' => 'James Bottomley', # wild guess
 'jejb:malley.(none)' => 'James Bottomley',
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
+'jejb:pashleys.(none)' => 'James Bottomley',
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
+'jejb:titanic.il.steeleye.com' => 'James Bottomley',
 'jelenz:edu.rmk.(none)' => 'John Lenz',
 'jelenz:students.wisc.edu' => 'John Lenz',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
@@ -1398,6 +1401,7 @@
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
+'luben_tuikov:adaptec.com' => 'Luben Tuikov',
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
 'luca.risolia:studio.unibo.it' => 'Luca Risolia',
 'luca:libero.it' => 'Luca Risolia',
@@ -1514,6 +1518,7 @@
 'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
 'mfedyk:matchmail.com' => 'Mike Fedyk',
 'mgalgoci:redhat.com' => 'Matthew Galgoci',
+'mgoodman:csua.berkeley.edu' => 'Mark Goodman',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhf:linuxmail.org' => 'Michael Frank',
@@ -2947,7 +2952,7 @@
       } else {
 	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-    } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
+    } elsif (/^\s+Signed[- _]off[- _]by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
       my @nameauthor = treat_address($1, $2);
       if ($namepref < 0) {
 	  ($name, $address, $author) = @nameauthor;



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAF90dEECA9VW227TQBB9zn7FqEXqDTu7tteOLVJKKYLSIqqWPlFAa3uSuLG9kXfdC4R/
Zx3TlgQVRKm42Jas9czJzJwzR8oy7O5EHS2rM5GnamuC5bDOSltXolQFamEnspg+HYlyiEeo
pw6ljrmZ41Kfh1Mn9DmfooOcJx4TcdALMHHIMhwrrKJOIbQeZULZokwrRPP9hVQ66gyLCztt
jodSmmP3TFTdONNjxAlW3e09a4xVibmlpcwVMXkHQicjOMNKRR1mu9df9OUEo87hs+fH+08O
Cen34bpV6PfJPY+lRIH5ViGy3E4+zqM9RplnsD03mPrc6flkB5jtuA5Qr8tol4VA3chzIxpu
UCeiFBa42Wo5gQ0GFiXbcM+tPyUJHNWTiaw0xLkoxwpMXajL1HCayArNWcG5rFJQOBGVMPUV
ZCUcZcMSU0sOBlZ8GYEWQ2WTPfDdkBzckE2sX7wIoYKSzZsxR7LAhRnVyHSby2E7Imc9GngB
601dFoR8OsBQDJKAhoJiKuL0FkLnfqVRKTRCudQQ5fRYQMgtqO/EvYJR2ozeiuvOicv9yKV/
TVwOJZ6DSE05pVA1Enns/5WI+044NYS7/szVVxlzpv7tfhYMvdjGzM/UN5vCQt5KTr27+Jn9
+35u3fAarOr8onmsC7M7V4TcYXV2nJBTYGT36xvM9RkwV9kAVrvvT9RG28hbCz68M83M3qah
E7W+9Hj17fuld+trS49N2smjVXt97WTTBB50szX4dKtlf2z0Vj6+6FjnZ/LxP+jYdt/vT4Rd
wwIz5K+cmj1XtipEpSMs6hwvmq5XoL8JKy+bGBw1sZWHDcQPZxA8jaOJUKMcL5W9WsoS174F
bEutZWGCLSig1yCdaVFmiW1MpTSiScHFavNgj87AeR1j+UHX2VieRSIVE43JDXC/icKbWXSG
4sxvUMVQyrQQZZSoWtgxVuOmoo1p3eJeiWoMz9scg7v+55CMMBmruuinsRMGAafkCzNBPBEK
CQAA

