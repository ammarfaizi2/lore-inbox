Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTFQLai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 07:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTFQLai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 07:30:38 -0400
Received: from ESS-p-144-138-96-110.mega.tmns.net.au ([144.138.96.110]:5006
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S264667AbTFQLah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 07:30:37 -0400
Subject: dnotify on a grand scale
From: Ben Martin <monkeyiq@users.sourceforge.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1055850404.8789.31.camel@sam>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jun 2003 21:46:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Firstly, could folks please CC me as I am not on the list.

  Background: I work on the libferris project and recently have added
both fulltext and attribute indexing (think Extended attributes).
http://witme.sourceforge.net/libferris.web/

  I am wishing to get a kind of extended output to what dnotify
currently gives which will allow be to keep a userland journal of all
file create, delete and modify actions. I am wanting this so that I can
run a cron job and only reindex the files that require it instead of
walking the filesystem and checking every file.

  I'm quite happy to tinker away and add such an interface and do the
hacking myself. I've read over the current dnotify code a little while
back. What I'm wondering is what sort of interface for this journaling
that I am preposing would be most likely to get integrated into the
mainline tree? I am open to suggestions as to how folks think this is
best implemented. 

I know C/C++ but don't know the kernel code much at all :(

Thanks.


