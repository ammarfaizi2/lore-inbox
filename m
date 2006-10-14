Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752209AbWJNURf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbWJNURf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 16:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWJNURf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 16:17:35 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:15446 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752210AbWJNURe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 16:17:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding;
  b=hvE641LIK9a6ZSO31Z0H6GSzkfr3dIKfLEeruWQXBb6qY8BkdPXKsY9loN1jgrXPIoQLVif7C7KF167WU5PHZv2e3dj9CEguzs1Gw8h36JbsHIY7APJ2mBa9I7Lg7WyNBR3ZkuYDlP9DpGiyyX0Z0OM3x73ldq0GAgVR64cwtq4=  ;
Message-ID: <453145DD.3040501@sbcglobal.net>
Date: Sat, 14 Oct 2006 16:17:33 -0400
From: "Robert W. Fuller" <garbageout@sbcglobal.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060814)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs file locking broken
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to upgrade from 2.6.16.27 to 2.6.17.13.  I have also tried
2.6.18.1.  I discovered NFS file locking no longer works between a Linux
client and an OpenBSD server.  For example, gtk-gnutella gets the
following error:

06-10-14 15:50:19 (WARNING): fcntl(8, F_SETLK, ...) failed for
"/home/edison/.gtk-gnutella/gtk-gnutella.pid": Permission denied

gpg hangs waiting for a lock for ~/.gnupg/random_seed
