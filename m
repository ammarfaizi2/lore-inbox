Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285845AbRLHG3q>; Sat, 8 Dec 2001 01:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285846AbRLHG3h>; Sat, 8 Dec 2001 01:29:37 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:29715 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285845AbRLHG31>; Sat, 8 Dec 2001 01:29:27 -0500
Date: Sat, 8 Dec 2001 07:29:21 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: reiserfs_delete_solid_item [ xxx xxx 0(1) DIR ] not found when FS full?
Message-ID: <20011208062921.GA3002@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was copying some tree and didn't notice my file-system filling up, but
I did notice this on the console (and in the logs):

Dec  8 07:17:31 alpha sudo: jurriaan : TTY=tty3 ; PWD=/var/spool ; USER=root ; COMMAND=/bin/cp -ax news testnews
Dec  8 07:22:03 alpha kernel: vs-5355: reiserfs_delete_solid_item: [434934 434961 0(1) DIR] not found<4>vs-5355: reiserfs_delete_soli
d_item: [434933 434961 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [434961 434962 0(1) DIR] not found<4>vs-5355: reise
rfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4
>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) D
IR] not found<4>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [43496
2 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_sol
id_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reis
erfs_delete_solid_item: [434962 434963 0(1) DIR] not found<4>vs-5355: reiserfs_delete_solid_it

Somehow, 'delete' is not what I expect when copying. Is this something
to worry about?

linux-2.4.17pre5, Alpha (EV56) system, more details on request.

Thanks,
Jurriaan
-- 
I am Ginsu of Borg. You will be assimilated - but WAIT! There's MORE!
GNU/Linux 2.4.17-pre5 on Debian/Alpha 64-bits 988 bogomips load:1.24 0.54 0.39
