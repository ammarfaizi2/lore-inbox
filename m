Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTDAEvs>; Mon, 31 Mar 2003 23:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262048AbTDAEvs>; Mon, 31 Mar 2003 23:51:48 -0500
Received: from mta01.alltel.net ([166.102.165.143]:56248 "EHLO
	mta01-srv.alltel.net") by vger.kernel.org with ESMTP
	id <S262046AbTDAEvs>; Mon, 31 Mar 2003 23:51:48 -0500
Message-ID: <3E891D8E.9E534400@alltel.net>
Date: Tue, 01 Apr 2003 00:03:10 -0500
From: "Paul Clements (home)" <pclements@alltel.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: unexporting sys_call_table a good idea?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

given the recent ptrace-related security bug, it sure would be nice to
have sys_call_table exported, so that I could just disable ptrace
altogether on affected systems (where no one is doing any debugging or
devel work, anyway)... I realize that there are race conditions, etc.,
with replacing syscalls, but could those not be solved?... as it is,
rather than being able to simply compile an external module (which
disables ptrace) and load it on affected systems, I am forced to
recompile an entire kernel, install it on the affected systems, and
reboot them all...

Thanks,
Paul
